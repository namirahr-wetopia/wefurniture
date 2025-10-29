import 'package:flutter/material.dart';
import '../theme/colors.dart';

class WidthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final bool doubleLabel;
  final String? secondText;

  const WidthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.doubleLabel = false,
    this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width ?? double.infinity,
      height:  h * 0.071,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGray.withAlpha(220),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
          foregroundColor: AppColors.white,
        ),
        child: doubleLabel
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      color:AppColors.white
                    ),
                  ),
                  VerticalDivider(
                    color: AppColors.white,
                    width: w*0.058,
                    thickness: w*0.0024,
                    indent: 8,
                    endIndent: 8,
                  ),
                  Text(
                    secondText ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                       color:AppColors.white
                    ),
                    ),
                ],
              )
            : Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  color:AppColors.white
                ),
              ),
      ),
    );
  }
}
