import 'package:flutter/material.dart';

/// A reusable profile avatar widget with Material Design styling
/// that supports edit functionality and anonymous mode.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.userName,
    this.imageUrl,
    this.isAnonymous = false,
    this.onEditPressed,
    this.radius = 50,
  });

  final String userName;
  final String? imageUrl;
  final bool isAnonymous;
  final VoidCallback? onEditPressed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.surface,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: colorScheme.primary,
              foregroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: TextStyle(
                        fontSize: radius * 0.7,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimary,
                        fontFamily: 'Gilroy',
                      ),
                    )
                  : null,
            ),
          ),
        ),
        // if (!isAnonymous && onEditPressed != null)
        //   Positioned(
        //     bottom: 0,
        //     right: 0,
        //     child: Container(
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: colorScheme.primary,
        //         border: Border.all(
        //           color: colorScheme.surface,
        //           width: 2,
        //         ),
        //       ),
        //       child: IconButton(
        //         onPressed: onEditPressed,
        //         icon: Icon(
        //           Icons.edit,
        //           size: 16,
        //           color: colorScheme.onPrimary,
        //         ),
        //         iconSize: 16,
        //         padding: const EdgeInsets.all(6),
        //         constraints: const BoxConstraints(
        //           minWidth: 28,
        //           minHeight: 28,
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
