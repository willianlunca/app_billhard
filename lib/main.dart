import 'package:app_billhard/screens/login.dart';
import 'package:app_billhard/screens/menu.dart';
import 'package:app_billhard/services/auth.dart';
import 'package:app_billhard/services/splashVideo.dart';
//import 'package:app_billhard/screens/termokip.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../colors/colors.dart';

final GlobalKey<NavigatorState> appNavigatorKey =
    GlobalKey<NavigatorState>(); // ⬅️ add

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://api.billhard.com.br',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyAgCiAgICAicm9sZSI6ICJhbm9uIiwKICAgICJpc3MiOiAic3VwYWJhc2UtZGVtbyIsCiAgICAiaWF0IjogMTY0MTc2OTIwMCwKICAgICJleHAiOiAxNzk5NTM1NjAwCn0.dc_X5iR_VP_qT0zsiyj_I_OZ2T9FtRU2BBNWN8Bu4GE',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      // 👇 em vez de colocar Login direto, colocamos um Shell
      home: const _AppShell(),
    );
  }
}

/// Shell que vive DENTRO do Navigator → aqui o Overlay existe.
class _AppShell extends StatefulWidget {
  const _AppShell({super.key});
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  @override
  void initState() {
    super.initState();
    // instala o overlay depois do 1º frame, com um contexto que já tem Overlay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalSideMenu.I.ensureInstalled(
        context,
        menuBuilder: (_) => const Menu(), // seu widget de menu
        width: 300,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Coloque aqui sua tela inicial real
    return const Login();
  }
}
