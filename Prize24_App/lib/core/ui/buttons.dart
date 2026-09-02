import 'package:flutter/material.dart';

class Primary1Button extends StatelessWidget {
  Primary1Button({
    required this.text,
    required this.onPressed,
    this.isLoading,
    this.iconData,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  bool? isLoading;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        // fixedSize: const Size(160, 50),
      ),
      onPressed:
          ((isLoading != null) && (isLoading! == true)) ? null : onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ((isLoading != null) && (isLoading! == true))
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (iconData != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        iconData,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class Secondary1Button extends StatelessWidget {
  Secondary1Button({
    required this.text,
    required this.onPressed,
    this.isLoading,
    this.iconData,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;
  bool? isLoading;
  IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ((isLoading != null) && (isLoading! == true))
            ? const SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(),
              )
            : Row(
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (iconData != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        iconData,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
