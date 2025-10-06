// menu.dart
import 'package:app_billhard/colors/colors.dart';
import 'package:app_billhard/screens/local.dart';
import 'package:app_billhard/screens/termokip.dart';
import 'package:flutter/material.dart';

/// =============== WIDGET DO SEU MENU =================
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _MenuItem('Filial', Icons.location_city),
      _MenuItem('Equipamento', Icons.category),
      _MenuItem('Filiação', Icons.group),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: const Text('Boa tarde!'),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: GlobalSideMenu.I.close,
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) {
              final it = items[i];
              return ListTile(
                leading: Icon(it.icon),
                title: Text(it.label),
                onTap: () {
                  // faça sua navegação aqui, se quiser
                  GlobalSideMenu.I.close();
                  print('🟢 Clicou em: ${it.label}');
                  // Ações específicas
                  switch (it.label) {
                    case 'Filial':
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const Local()),
                      );
                      break;

                    case 'Equipamento':
                      print('⚙️ Abrindo tela de Equipamentos...');
                      break;

                    case 'Filiação':
                      print('👥 Abrindo tela de Filiação...');
                      break;

                    default:
                      print('❓ Item não reconhecido.');
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;
  const _MenuItem(this.label, this.icon);
}

/// =============== CONTROLADOR GLOBAL =================
/// Instale 1x no MaterialApp.builder e depois chame:
///   GlobalSideMenu.I.set(true/false)  ou  GlobalSideMenu.I.toggle()
class GlobalSideMenu {
  GlobalSideMenu._();
  static final GlobalSideMenu I = GlobalSideMenu._();

  final ValueNotifier<bool> isOpen = ValueNotifier<bool>(false);
  OverlayEntry? _entry;

  late WidgetBuilder _menuBuilder;
  double _width = 280;
  Duration _duration = const Duration(milliseconds: 260);
  Curve _curve = Curves.easeOutCubic;
  Color _backdropColor = const Color(0x73000000); // preto ~45%

  void ensureInstalled(
    BuildContext context, {
    required WidgetBuilder menuBuilder,
    double width = 280,
    Duration duration = const Duration(milliseconds: 260),
    Curve curve = Curves.easeOutCubic,
    Color backdropColor = const Color(0x73000000),
  }) {
    _menuBuilder = menuBuilder;
    _width = width;
    _duration = duration;
    _curve = curve;
    _backdropColor = backdropColor;

    if (_entry != null) return; // já instalado
    _entry = OverlayEntry(builder: (_) => _SideMenuOverlay(controller: this));
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  // Controles públicos
  void open() => isOpen.value = true;
  void close() => isOpen.value = false;
  void set(bool open) => isOpen.value = open;
  void toggle() => isOpen.value = !isOpen.value;

  void dispose() {
    _entry?.remove();
    _entry = null;
  }
}

class _SideMenuOverlay extends StatelessWidget {
  final GlobalSideMenu controller;
  const _SideMenuOverlay({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.isOpen,
      builder: (ctx, open, _) {
        return IgnorePointer(
          ignoring: !open, // não intercepta cliques quando fechado
          child: Stack(
            children: [
              // backdrop
              AnimatedOpacity(
                duration: controller._duration,
                opacity: open ? 1 : 0,
                child: GestureDetector(
                  onTap: controller.close,
                  child: Container(color: controller._backdropColor),
                ),
              ),
              // menu lateral (esquerda)
              AnimatedPositioned(
                duration: controller._duration,
                curve: controller._curve,
                top: 0,
                bottom: 0,
                left: open ? 0 : -controller._width,
                width: controller._width,
                child: Material(
                  elevation: 12,

                  color: bege,
                  child: SafeArea(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        // ícones
                        iconTheme: const IconThemeData(color: Colors.white),

                        // ListTiles (ícone + texto)
                        listTileTheme: const ListTileThemeData(
                          iconColor: Colors.black,
                          textColor: Colors.black,
                        ),

                        // textos em geral
                        textTheme: Theme.of(context).textTheme.apply(
                          bodyColor: Colors.white,
                          displayColor: Colors.white,
                        ),
                        // 🔥 Aqui controla a cor/espessura de TODAS as divisórias
                        dividerTheme: const DividerThemeData(
                          color: Colors.grey, // mude aqui
                          thickness: 1,
                        ),
                      ),
                      child: controller._menuBuilder(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
