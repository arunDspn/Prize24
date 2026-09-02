import 'package:flutter/material.dart';

class _DesignColors {
  // Page colors
  static const Color pageBg = Color(0xFFF8FAFC); // slate-50
  static const Color pageCard = Color(0xFFFFFFFF); // white
  static const Color pageInput = Color(0xFFF1F5F9); // slate-100
  static const Color pageSubtle = Color(0xFFE2E8F0); // slate-200

  // Text colors
  static const Color textMain = Color(0xFF1E293B); // slate-800
  static const Color textSub = Color(0xFF64748B); // slate-500
  static const Color textAccent = Color(0xFF0F172A); // slate-900

  // Brand gradient colors
  static const Color brandStart = Color(0xFFEF4444); // red-500
  static const Color brandEnd = Color(0xFFF97316); // orange-500

  // Success colors (green)
  static const Color successBg = Color(0xFFECFDF5); // green-50
  static const Color successBorder = Color(0xFFBBF7D0); // green-200
  static const Color successIcon = Color(0xFF16A34A); // green-600
  static const Color successText = Color(0xFF166534); // green-800
  static const Color successTextLight = Color(0xFF15803D); // green-700

  // Error colors (red)
  static const Color errorBg = Color(0xFFFEF2F2); // red-50
  static const Color errorBorder = Color(0xFFFECACA); // red-200
  static const Color errorIcon = Color(0xFFEF4444); // red-500
  static const Color errorText = Color(0xFFB91C1C); // red-700

  // Info colors (blue)
  static const Color infoBg = Color(0xFFEFF6FF); // blue-50
  static const Color infoBorder = Color(0xFFDBEAFE); // blue-100
  static const Color infoIcon = Color(0xFF3B82F6); // blue-500
  static const Color infoText = Color(0xFF1D4ED8); // blue-700

  static const Gradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [brandStart, brandEnd],
  );
}

void showToastAtTop(BuildContext context, String message, bool isSuccess) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -20 * (1 - value)),
                child: Opacity(
                  opacity: value,
                  child: child,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isSuccess
                    ? _DesignColors.successIcon
                    : _DesignColors.errorIcon,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSuccess
                        ? Icons.check_circle_rounded
                        : Icons.warning_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), overlayEntry.remove);
}

class _GetStartColors {
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  static const Color orange300 = Color(0xFFFDBA74);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
  static const Color red300 = Color(0xFFFCA5A5);
  static const Color red500 = Color(0xFFEF4444);
  static const Color purple200 = Color(0xFFE9D5FF);
  static const Color purple500 = Color(0xFFA855F7);
  static const Color green500 = Color(0xFF22C55E);
  static const Color green600 = Color(0xFF16A34A);
  static const Color blue400 = Color(0xFF60A5FA);

  // Gradient colors
  static const Color brandStart = Color(0xFFFF5F6D);
  static const Color brandEnd = Color(0xFFFFC371);
}

void showToastAtTop2(String message, ToastType type, BuildContext context) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _ToastWidget(
      message: message,
      type: type,
      onDismiss: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);
}

enum ToastType { success, error, neutral }

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<double>(begin: -30, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.reverse().then((_) => widget.onDismiss());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    IconData icon;

    switch (widget.type) {
      case ToastType.success:
        bgColor = _GetStartColors.green600;
        icon = Icons.check_circle;
        break;
      case ToastType.error:
        bgColor = _GetStartColors.red500;
        icon = Icons.warning_rounded;
        break;
      case ToastType.neutral:
        bgColor = _GetStartColors.slate900;
        icon = Icons.info_rounded;
        break;
    }

    return Positioned(
      top: MediaQuery.of(context).padding.top + 24,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _slideAnimation.value),
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 380),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gilroy',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
