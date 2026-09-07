import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

typedef PhoneUriLauncher = Future<bool> Function(Uri uri);

class PhoneNumberLink extends StatelessWidget {
  const PhoneNumberLink({
    required this.phoneNumber,
    this.launcher = launchUrl,
    this.iconColor,
    this.iconSize = 16,
    this.showIcon = true,
    this.textStyle,
    super.key,
  });

  final String phoneNumber;
  final PhoneUriLauncher launcher;
  final Color? iconColor;
  final double iconSize;
  final bool showIcon;
  final TextStyle? textStyle;

  Future<void> _call(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (await launcher(uri)) return;
    } on Exception {
      // Fall through to the user-facing error below.
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to open the phone dialer.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      link: true,
      label: 'Call $phoneNumber',
      child: InkWell(
        onTap: () => _call(context),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon) ...[
                Icon(Icons.phone_outlined, size: iconSize, color: iconColor),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  phoneNumber,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
