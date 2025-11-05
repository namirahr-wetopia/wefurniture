import 'package:flutter/material.dart';

class StepButton extends StatelessWidget {
  const StepButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return InkResponse(
      onTap: onTap,
      radius: w * 0.0438,
      child: Container(
        width: w * 0.0633,
        height: w * 0.0633,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}