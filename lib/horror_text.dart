import 'package:flutter/material.dart';

class HorrorImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool hasFrame;
  final Color frameColor;

  const HorrorImage({
    Key? key,
    required this.imageUrl,
    this.size = 120,
    this.hasFrame = false,
    this.frameColor = const Color(0xFF8B0000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // تأثير الظل
        Container(
          width: size + 20,
          height: size + 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: frameColor.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
        ),

        // الإطار
        if (hasFrame)
          Container(
            width: size + 10,
            height: size + 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: frameColor, width: 3),
              boxShadow: [
                BoxShadow(
                  color: frameColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

        // الصورة
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),

        // تأثير وميض
        Positioned.fill(
          child: ClipOval(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [Colors.transparent, frameColor.withOpacity(0.1)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
