import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    required this.text,
    this.width = 280,
    super.key,
    this.onPressed,
    this.isOutlined = false,
  });
  final VoidCallback? onPressed;
  final double? width;
  final String text;
  final bool isOutlined;
  @override
  Widget build(BuildContext context) {
    List<Color> mainColorsList = [Colors.orange, Colors.pink];
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: isOutlined
                  ? mainColorsList
                  : [
                      Colors.white,
                      Colors.white,
                    ],
            ).createShader(bounds),
            child: Container(
              width: width,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isOutlined ? Colors.white : Colors.transparent,
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: const [
                    0.15,
                    0.75,
                  ],
                  tileMode: TileMode.mirror,
                  colors: isOutlined
                      ? [
                          Colors.transparent,
                          Colors.transparent,
                        ]
                      : mainColorsList,
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  onPressed?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Text(
                  text,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isOutlined ? Colors.transparent : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          if (isOutlined)
            IgnorePointer(
              child: Text(
                text,
                style: const TextStyle(fontSize: 17),
              ),
            )
        ],
      ),
    );
  }
}
