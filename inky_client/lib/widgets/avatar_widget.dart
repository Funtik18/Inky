import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class AvatarWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final double radius;

  const AvatarWidget({super.key, this.onTap, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: AppStyles.backgroundColor,
        child: Icon(Icons.person, color: AppStyles.avatarAnonColor),
      ),
    );
  }
}
