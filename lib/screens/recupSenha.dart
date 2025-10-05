import 'package:app_billhard/colors/colors.dart';
import 'package:app_billhard/screens/login.dart';
import 'package:app_billhard/services/auth.dart';
import 'package:app_billhard/services/splashVideo.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 🔄 Tornamos stateful para preservar os controllers entre rebuilds.
// (isso evita perder o texto quando um TextField com obscureText: true recebe foco)
class RecSenha extends StatefulWidget {
  const RecSenha({super.key});

  @override
  State<RecSenha> createState() => _RecSenha();
}

class _RecSenha extends State<RecSenha> {
  // ✅ Controllers agora vivem no State (não são recriados a cada build)
  late final TextEditingController emailController;
  late final TextEditingController senhaController;
  late final TextEditingController confirmSenhaController;

  @override
  void initState() {
    super.initState();
    // ✅ Instancia uma única vez
    emailController = TextEditingController();
    senhaController = TextEditingController();
    confirmSenhaController = TextEditingController();
  }

  @override
  void dispose() {
    // ✅ Libera recursos corretamente
    emailController.dispose();
    senhaController.dispose();
    confirmSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ Mantido exatamente como no seu layout
    final bool tecladoAberto = MediaQuery.of(context).viewInsets.bottom > 0;
    final supa = Supabase.instance.client;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: verdePrincipal,
        title: Text(
          'Recuperação de Senha',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // 🔙 cor da seta de voltar
        ),
      ),
      backgroundColor: verdePrincipal,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(
                          milliseconds: 800,
                        ), // ⏳ mais lento
                        switchInCurve: Curves.easeInOutCubic, // entra suave
                        switchOutCurve: Curves.easeInOutCubic, // sai suave
                        transitionBuilder: (child, animation) {
                          // Fade + Slide suave
                          final slide =
                              Tween<Offset>(
                                begin: const Offset(
                                  0,
                                  -0.25,
                                ), // movimento menor e mais sutil
                                end: Offset.zero,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves
                                      .easeInOut, // curva suave também no slide
                                ),
                              );

                          return FadeTransition(
                            opacity: CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut, // fade lento e suave
                            ),
                            child: SlideTransition(
                              position: slide,
                              child: child,
                            ),
                          );
                        },
                        child: tecladoAberto
                            ? const SizedBox.shrink(key: ValueKey('sem_logo'))
                            : Container(
                                key: const ValueKey('logo'),
                                height: 120,
                                margin: const EdgeInsets.only(
                                  top: 40,
                                  bottom: 20,
                                ),
                                child: Image.asset(
                                  'assets/logo/billhard-versao-3.png',
                                ),
                              ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: MediaQuery.of(context).size.width * 0.93,
                        height: 240,
                        child: Column(
                          children: [
                            Text(
                              'Recuperar senha',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Inter',
                                fontSize: 24,
                                color: verdePrincipal,
                              ),
                            ),
                            Text(
                              'Digite seu e-mail para recuperar sua senha',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: verdePrincipal,
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.88,
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    child: Text(
                                      'E-mail',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.88,
                              child: TextField(
                                controller:
                                    emailController, // 👈 persiste entre rebuilds
                                decoration: InputDecoration(
                                  hintText: "seu@email.com", // placeholder
                                  hintStyle: TextStyle(
                                    color:
                                        Colors.grey[400], // cor do placeholder
                                  ),
                                  filled: true,
                                  fillColor: Colors.white, // fundo do input
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // cor da borda quando não focado
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color:
                                          verdePrincipal, // cor da borda quando focado
                                      width: 2,
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.black, // cor do texto digitado
                                ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width:
                                  MediaQuery.of(context).size.width *
                                  0.88, // 93% da largura da tela
                              child: ElevatedButton(
                                onPressed: () async {
                                  await updateSplash(context, show: true);
                                  try {
                                    await supa.auth.resetPasswordForEmail(
                                      emailController.text.trim(),
                                      redirectTo:
                                          'https://billhard.com.br/recovery-pwd.html',
                                    );

                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Enviamos um e-mail para redefinir sua senha.',
                                        ),
                                      ),
                                    );
                                  } on AuthException catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Erro: ${e.message}'),
                                      ),
                                    );
                                  } finally {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const Login(),
                                      ),
                                    );
                                    await updateSplash(context, show: false);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: terraCota,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14, // altura do botão
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Recuperar Senha",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
