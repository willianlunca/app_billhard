import 'package:app_billhard/screens/login.dart';
import 'package:app_billhard/screens/termokip.dart';
import 'package:app_billhard/services/splashVideo.dart';
import 'package:app_billhard/services/supabaseErrors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'dart:async';

final supabase = Supabase.instance.client;

class AuthSupabase {
  final log = Logger('AuthSupabase');

  Future<String?> entrarUsuario({
    required BuildContext context,
    required String email,
    required String senha,
  }) async {
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe e-mail e senha.')));
      return "campos_vazios";
    }
    if (!emailRegex.hasMatch(email.trim())) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite um e-mail válido.')));
      return "email_invalido";
    }

    try {
      final supa = Supabase.instance.client;
      final res = await supa.auth.signInWithPassword(
        email: email.trim(),
        password: senha,
      );

      final user = res.user;
      if (user == null) return "";

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bem-vindo, ${user.email ?? 'usuário'}!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Live()),
        );
      }
    } on AuthException catch (error) {
      // --- Tratamento de conta não confirmada + reenvio ---
      final msg = error.message.toLowerCase();
      final naoConfirmado =
          msg.contains('not confirmed') ||
          msg.contains('confirm') ||
          msg.contains('unconfirmed');

      if (naoConfirmado) {
        try {
          await Supabase.instance.client.auth.resend(
            type: OtpType.signup,
            email: email.trim(),
          );
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Sua conta ainda não foi confirmada. Reenviamos o e-mail para ${email.trim()}.',
                ),
              ),
            );
          }
          return "reenviado_confirmacao";
        } catch (_) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Não conseguimos reenviar o e-mail de confirmação. Aguarde alguns instantes e tente novamente.',
                ),
              ),
            );
          }
          return "falha_reenvio_confirmacao";
        }
      }

      // --- Outros erros ---
      log.severe("error de autenticação: ${error.message}");
      final texto = traduzirSupabaseErro(error.message);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(texto)));
      }
      return "error: ${error.message}";
    }
    return null;
  }

  // Função para cadastrar usuário
  Future<String?> cadastrarUsuario({
    required BuildContext context,
    required String email,
    required String senha,
    required String confPwd,
  }) async {
    final supa = Supabase.instance.client;

    // Validações
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (email.isEmpty || senha.isEmpty || confPwd.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Informe e-mail e senha.')));
      return "campos_vazios";
    }
    if (!emailRegex.hasMatch(email.trim())) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite um e-mail válido.')));
      return "email_invalido";
    }
    if (senha != confPwd) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('As senhas não coincidem.')));
      return "senhas_diferentes";
    }

    try {
      final res = await supa.auth.signUp(
        email: email.trim(),
        password: senha,
        // emailRedirectTo: 'io.billhard.app://login-callback', // se usar deep link
      );

      // Se exige confirmação de e-mail, a session virá null
      if (!context.mounted) return null;
      if (res.session == null) {
        // Conta nova criada, mas ainda sem confirmar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Enviamos um e-mail de confirmação. Verifique sua caixa de entrada.',
            ),
          ),
        );
        // Opcionalmente volte ao login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Login()),
        );
        return "aguardando_confirmacao_email";
      }

      // Caso confirmação esteja desativada e já venha logado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Usuário ${res.user?.email ?? ''} cadastrado com sucesso!',
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/live'),
          builder: (_) => const Live(),
        ),
      );
      return "cadastrado_logado";
    } on AuthException catch (e) {
      final msg = e.message.toLowerCase();

      // 🎯 Detecta "já existe"

      // Demais erros
      if (context.mounted) {
        final texto = traduzirSupabaseErro(e.message);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(texto)));
      }
      return "erro_auth: ${e.message}";
    } catch (err, st) {
      debugPrint('Erro inesperado no cadastro: $err\n$st');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ocorreu um erro inesperado.')),
        );
      }
      return "erro_inesperado";
    }
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final Stream<AuthState> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = Supabase.instance.client.auth.onAuthStateChange;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: _authStream,
      builder: (context, snapshot) {
        final data = snapshot.data;
        final session = data?.session;

        if (session == null) {
          return const Login(); // usuário não logado
        } else {
          return const Live(); // usuário logado
        }
      },
    );
  }
}

/// 🔎 Verifica se existe uma sessão ativa no Supabase.
/// Retorna `true` se o usuário está logado, `false` caso contrário.
bool hasActiveSession() {
  final session = supabase.auth.currentSession;
  return session != null;
}

/// 🔎 Retorna o usuário logado ou `null`.
User? getCurrentUser() {
  return supabase.auth.currentUser;
}

/// 🔎 Busca o `id` de um usuário no Supabase passando o e-mail.
/// ⚠️ Só funciona se você já estiver autenticado com uma conta que tenha permissão.
/// 🔎 Busca o ID de um usuário pelo e-mail (usando a RPC criada no Supabase)
Future<String?> getUserIdByEmail(String email) async {
  try {
    final result = await supabase.rpc(
      'get_user_id_by_email',
      params: {'p_email': email},
    );

    if (result == null) {
      debugPrint("Usuário não encontrado para e-mail: $email");
      return null;
    }

    return result as String;
  } on PostgrestException catch (e) {
    debugPrint("Erro RPC: ${e.message}");
    return null;
  } catch (e) {
    debugPrint("Erro inesperado: $e");
    return null;
  }
}
