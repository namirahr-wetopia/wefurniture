import 'package:flutter/material.dart';
import '../theme/colors.dart';


class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.0389, h * 0.0337, w * 0.0389,  h * 0.0224 ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Discover the Best\nFurniture',
              style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    color:AppColors.darkestGray
                  ),
            ),
          ),
           CircleAvatar(
            radius: w * 0.0681,
            backgroundImage: AssetImage(
              'assets/images/profile.jpg',
            ),
          ),
        ],
      ),
    );
  }
}