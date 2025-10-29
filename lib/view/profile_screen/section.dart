import 'package:flutter/material.dart';
import '../theme/colors.dart' show AppColors;
import 'tile.dart';

class Section extends StatelessWidget {
  final String title;
  final List<ProfileOption> tiles;

  const Section({super.key, required this.title, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          color: Colors.grey.shade100,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05, 
              vertical: h * 0.014,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: h * 0.0188,
                color: AppColors.mediumGray,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        ...List.generate(
          tiles.length,
          (i) => Column(
            children: [
              tiles[i],
            ],
          ),
        ),
      ]),
    );
  }
}
