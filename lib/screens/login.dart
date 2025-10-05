import 'package:app_billhard/colors/colors.dart';
import 'package:app_billhard/screens/novoUsuario.dart';
import 'package:app_billhard/screens/recupSenha.dart';
import 'package:app_billhard/screens/termokip.dart';
import 'package:app_billhard/services/auth.dart';
import 'package:app_billhard/services/splashVideo.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ✅ Controllers agora vivem no State (não serão recriados a cada build).
  late final TextEditingController emailController;
  late final TextEditingController senhaController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    senhaController = TextEditingController();
  }

  @override
  void dispose() {
    // ✅ Libera os recursos corretamente.
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ⚠️ Mantido exatamente como no seu layout.
    final bool tecladoAberto = MediaQuery.of(context).viewInsets.bottom > 0;
    final supa = Supabase.instance.client;

    return Scaffold(
      backgroundColor: verdePrincipal,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          child: SlideTransition(position: slide, child: child),
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

                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: MediaQuery.of(context).size.width * 0.93,
                            height: 400,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Acesse sua conta',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Inter',
                                          fontSize: 24,
                                          color: verdePrincipal,
                                        ),
                                      ),
                                      Text(
                                        'Entre com suas credenciais para continuar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          color: verdePrincipal,
                                        ),
                                      ),
                                      Row(
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

                                      // ✅ Mantido igual; só que agora o controller é persistente no State.
                                      TextField(
                                        controller:
                                            emailController, // 👈 persiste entre rebuilds
                                        decoration: InputDecoration(
                                          hintText:
                                              "seu@email.com", // placeholder
                                          hintStyle: TextStyle(
                                            color: Colors
                                                .grey[400], // cor do placeholder
                                          ),
                                          filled: true,
                                          fillColor:
                                              Colors.white, // fundo do input
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors
                                                  .grey, // cor da borda quando não focado
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide(
                                              color:
                                                  verdePrincipal, // cor da borda quando focado
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors
                                              .black, // cor do texto digitado
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                            ),
                                            child: Text(
                                              'Senha',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // ✅ Mantido igual; obscureText continua true (mas agora não apaga o e-mail).
                                      SizedBox(
                                        child: TextField(
                                          controller:
                                              senhaController, // persiste
                                          obscureText:
                                              true, // 👈 mantém a máscara
                                          obscuringCharacter: '•',
                                          decoration: InputDecoration(
                                            hintText: "••••••••", // placeholder
                                            hintStyle: TextStyle(
                                              color: Colors
                                                  .grey[400], // cor do placeholder
                                            ),
                                            filled: true,
                                            fillColor:
                                                Colors.white, // fundo do input
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: Colors
                                                    .grey, // cor da borda quando não focado
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color:
                                                    verdePrincipal, // cor da borda quando focado
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          style: TextStyle(
                                            color: Colors
                                                .black, // cor do texto digitado
                                          ),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.93, // 93% da largura da tela
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await updateSplash(
                                              context,
                                              show: true,
                                            );
                                            await AuthSupabase().entrarUsuario(
                                              context: context,
                                              email: emailController.text
                                                  .trim(),
                                              senha: senhaController.text,
                                            );
                                            if (context.mounted) {
                                              await updateSplash(
                                                context,
                                                show: false,
                                              );
                                            }
                                            ;
                                            if (!context.mounted) {
                                              Navigator.of(
                                                context,
                                              ).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (_) => const Login(),
                                                ),
                                                (Route<dynamic> route) =>
                                                    false, // remove todas as rotas anteriores
                                              );
                                            }
                                          },

                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: terraCota,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14, // altura do botão
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "Entrar",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              /**
                                               * await supa.auth.resetPasswordForEmail(
                                                  'willian_lunca@hotmail.com'
                                                      .trim(), // use o e-mail digitado
                                                  redirectTo:
                                                      'https://billhard.com.br/recovery-pwd.html',
                                                );
                                               */
                                              onTap: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        const RecSenha(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Esqueci minha senha",
                                                style: TextStyle(
                                                  color: verdePrincipal,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight
                                                      .w400, // sublinhado
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Não tem uma conta ? ',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: verdePrincipal,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // Navega para a tela de criar conta
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const NewUser(),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Criar conta",
                                                style: TextStyle(
                                                  color: verdePrincipal,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight
                                                      .w400, // sublinhado
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Texto com link
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              '© 2024 Billhard. Todos os direitos reservados.',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: verdeSecundario,
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
    );
  }
}

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Conta")),
      backgroundColor: verdePrincipal,
      body: Center(
        child: SizedBox(
          child: Image.asset(
            'assets/gif/motion_billhard.mp4',
            // largura da imagem
            height: 80, // altura da imagem
          ),
        ),
      ),
    );
  }
}

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(child: Image.asset('assets/gif/motion_billhard.webp')),
      ),
    );
  }
}
