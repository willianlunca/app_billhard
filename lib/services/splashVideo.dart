import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashVideoPage extends StatefulWidget {
  const SplashVideoPage({super.key});

  @override
  State<SplashVideoPage> createState() => _SplashVideoPageState();
}

class _SplashVideoPageState extends State<SplashVideoPage> {
  late final VideoPlayerController _controller;
  bool _navegou = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.asset('assets/gif/billhard_verde.mp4');

    try {
      // 1) Inicializa aguardando de verdade
      await _controller.initialize();

      // 2) Atualiza UI para desenhar o primeiro frame
      if (!mounted) return;
      setState(() {});

      // 3) Só depois que o frame foi pintado, dá o play
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!mounted) return;
        await _controller.setLooping(false);
        await _controller.setVolume(0);
        await _controller.play();
      });

      // 4) Quando terminar, navega
      _controller.addListener(() {
        final v = _controller.value;
        if (v.isInitialized &&
            !v.isPlaying &&
            v.position >= v.duration &&
            !_navegou) {
          _onVideoEnd();
        }
      });

      // 5) Failsafe: se algo travar, navega em X segundos
      Future.delayed(const Duration(seconds: 6), () {
        if (!_navegou) _onVideoEnd();
      });
    } catch (e) {
      debugPrint('💥 erro init: $e');
      _onVideoEnd();
    }
  }

  void _onVideoEnd() {
    if (_navegou || !mounted) return;
    _navegou = true;
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const AuthWrapper()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _controller.value.isInitialized
            ? SizedBox(
                width: 320, // 👈 limita a largura
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}

/// Chame assim:
///   await showBillhardSplash(context, toAuthWrapper: true);
///   await showBillhardSplash(context, toAuthWrapper: false, redirectTo: const MinhaPagina());
// ====== API PÚBLICA ======

Future<void> updateSplash(
  BuildContext context, {
  required bool show,

  // opções (somente usadas quando show:true)
  String assetPath = 'assets/gif/billhard_verde.mp4',
  bool loop = false,
  Duration failsafe = const Duration(seconds: 600),
  Color backgroundColor = Colors.white,
  double maxWidth = 320,
  bool toAuthWrapper = false,
  Widget? redirectTo,
}) async {
  if (show) {
    // Define o que acontece quando o vídeo terminar/failsafe disparar
    VoidCallback? onAutoFinish;
    if (toAuthWrapper || redirectTo != null) {
      final Widget next = toAuthWrapper ? const AuthWrapper() : redirectTo!;
      onAutoFinish = () {
        final nav = Navigator.of(context);
        // Remover o overlay antes de navegar (caso ainda esteja visível)
        BillhardSplash.hide();
        nav.pushReplacement(MaterialPageRoute(builder: (_) => next));
      };
    }

    BillhardSplash.show(
      context,
      assetPath: assetPath,
      loop: loop,
      failsafe: failsafe,
      backgroundColor: backgroundColor,
      maxWidth: maxWidth,
      onAutoFinish: onAutoFinish,
    );
    await Future.delayed(const Duration(milliseconds: 1500));
  } else {
    BillhardSplash.hide(); // interrompe e some
  }
}

// ====== IMPLEMENTAÇÃO ======

class BillhardSplash {
  static OverlayEntry? _entry;
  static final GlobalKey<_SplashOverlayState> _key =
      GlobalKey<_SplashOverlayState>();

  static bool get isShowing => _entry != null;

  static void show(
    BuildContext context, {
    required String assetPath,
    required bool loop,
    required Duration failsafe,
    required Color backgroundColor,
    required double maxWidth,
    VoidCallback? onAutoFinish,
  }) {
    if (_entry != null) return; // já está visível

    _entry = OverlayEntry(
      builder: (_) => _SplashOverlay(
        key: _key,
        assetPath: assetPath,
        loop: loop,
        failsafe: failsafe,
        backgroundColor: backgroundColor,
        maxWidth: maxWidth,
        onAutoFinish: () {
          // pede para esconder com animação e depois remove
          _key.currentState?._hideAndRemove(then: onAutoFinish);
        },
      ),
    );

    final overlay = Overlay.of(context, rootOverlay: true);
    overlay.insert(_entry!);
  }

  static void hide() {
    if (_entry == null) return;
    _key.currentState?._hideAndRemove();
  }

  static void _removeEntry() {
    _entry?.remove();
    _entry = null;
  }
}

class _SplashOverlay extends StatefulWidget {
  const _SplashOverlay({
    super.key,
    required this.assetPath,
    required this.loop,
    required this.failsafe,
    required this.backgroundColor,
    required this.maxWidth,
    this.onAutoFinish,
  });

  final String assetPath;
  final bool loop;
  final Duration failsafe;
  final Color backgroundColor;
  final double maxWidth;
  final VoidCallback? onAutoFinish;

  @override
  State<_SplashOverlay> createState() => _SplashOverlayState();
}

class _SplashOverlayState extends State<_SplashOverlay>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _controller;
  bool _visible = false; // para o fade
  bool _done = false;

  static const _fade = Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _controller = VideoPlayerController.asset(widget.assetPath);

    try {
      await _controller.initialize();
      if (!mounted) return;

      await _controller.setLooping(widget.loop);
      await _controller.setVolume(0);
      await _controller.play();

      // exibe com fade-in
      setState(() => _visible = true);

      // listener para fim do vídeo quando não está em loop
      _controller.addListener(() {
        final v = _controller.value;
        if (v.isInitialized &&
            !widget.loop &&
            !v.isPlaying &&
            v.position >= v.duration) {
          _triggerAutoFinish();
        }
      });

      // failsafe
      Future.delayed(widget.failsafe, () {
        if (mounted && !_done) _triggerAutoFinish();
      });
    } catch (e) {
      debugPrint('Splash init error: $e');
      _triggerAutoFinish();
    }
  }

  void _triggerAutoFinish() {
    if (_done) return;
    _done = true;
    widget.onAutoFinish?.call();
  }

  // chamado por BillhardSplash.hide() OU pelo onAutoFinish
  void _hideAndRemove({VoidCallback? then}) async {
    if (!mounted) {
      _disposeAndRemove();
      then?.call();
      return;
    }
    setState(() => _visible = false); // fade-out
    // aguarda o fade
    await Future.delayed(_fade);
    _disposeAndRemove();
    then?.call();
  }

  void _disposeAndRemove() {
    try {
      _controller.pause();
      _controller.dispose();
    } catch (_) {}
    BillhardSplash._removeEntry();
  }

  @override
  void dispose() {
    if (_controller.value.isInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = _controller.value.isInitialized
        ? Center(
            child: SizedBox(
              width: widget.maxWidth,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio == 0
                    ? 16 / 9
                    : _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());

    return Material(
      color: widget.backgroundColor,
      child: AnimatedOpacity(
        duration: _fade,
        opacity: _visible ? 1 : 0,
        child: child,
      ),
    );
  }
}

// ====== EXEMPLO DE USO ======

// 1) Mostrar splash e navegar para AuthWrapper quando terminar:
// await updateSplash(context, show: true, toAuthWrapper: true);

// 2) Em outro ponto do código, interromper e esconder imediatamente:
// await updateSplash(context, show: false);

// 3) Mostrar splash e navegar para uma página específica quando terminar:
// await updateSplash(
//   context,
//   show: true,
//   redirectTo: const Live(),
//   loop: false,
//   failsafe: const Duration(seconds: 20),
// );

// 4) Mostrar splash apenas como “tampa” temporária (sem navegação automática):
// await updateSplash(context, show: true, loop: true);
// ...
// await updateSplash(context, show: false);

// ====== PLACEHOLDERS ======
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Text('AuthWrapper')));
}
