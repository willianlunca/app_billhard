import 'package:app_billhard/colors/colors.dart';
import 'package:flutter/material.dart';

class NewUser extends StatelessWidget {
  const NewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final bool tecladoAberto = MediaQuery.of(context).viewInsets.bottom > 0;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController senhaController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Novo Usuário'),
      ),
      backgroundColor: verdePrincipal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                // Fade + Slide suave
                final slide = Tween<Offset>(
                  begin: const Offset(
                    0,
                    -0.08,
                  ), // leve de cima p/ baixo ao entrar
                  end: Offset.zero,
                ).animate(animation);
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: tecladoAberto
                  ? const SizedBox.shrink(key: ValueKey('sem_logo'))
                  : Container(
                      key: const ValueKey('logo'),
                      height: 80,
                      margin: const EdgeInsets.only(top: 40, bottom: 20),
                      child: Image.asset('assets/logo/billhard-versao-3.png'),
                    ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              width: MediaQuery.of(context).size.width * 0.93,
              height: 420,
              child: Column(
                children: [
                  Text(
                    'Crie sua conta',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      fontSize: 24,
                      color: verdePrincipal,
                    ),
                  ),
                  Text(
                    'Digite seu e-mail e escolha sua senha',
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
                          margin: EdgeInsets.only(bottom: 10, top: 10),
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
                      controller: emailController, // 👈 agora funciona
                      decoration: InputDecoration(
                        hintText: "seu@email.com", // placeholder
                        hintStyle: TextStyle(
                          color: Colors.grey[400], // cor do placeholder
                        ),
                        filled: true,
                        fillColor: Colors.white, // fundo do input
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color:
                                Colors.grey, // cor da borda quando não focado
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: verdePrincipal, // cor da borda quando focado
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // cor do texto digitado
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: TextField(
                      controller: senhaController, // 👈 agora funciona
                      obscureText: true, // 👈 isso oculta o texto digitado
                      decoration: InputDecoration(
                        hintText: "••••••••", // placeholder
                        hintStyle: TextStyle(
                          color: Colors.grey[400], // cor do placeholder
                        ),
                        filled: true,
                        fillColor: Colors.white, // fundo do input
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color:
                                Colors.grey, // cor da borda quando não focado
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: verdePrincipal, // cor da borda quando focado
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // cor do texto digitado
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10, top: 10),
                          child: Text(
                            'Confirmar senha',
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
                      controller: senhaController, // 👈 agora funciona
                      obscureText: true, // 👈 isso oculta o texto digitado
                      decoration: InputDecoration(
                        hintText: "••••••••", // placeholder
                        hintStyle: TextStyle(
                          color: Colors.grey[400], // cor do placeholder
                        ),
                        filled: true,
                        fillColor: Colors.white, // fundo do input
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color:
                                Colors.grey, // cor da borda quando não focado
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: verdePrincipal, // cor da borda quando focado
                            width: 2,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black, // cor do texto digitado
                      ),
                    ),
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
