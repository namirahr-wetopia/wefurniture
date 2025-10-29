import 'package:flutter/material.dart';
import '../theme/colors.dart';

class Categories extends StatefulWidget {
  const Categories();

  @override
  State<Categories> createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
  int selected = 0;
  final cats = const ['Chairs', 'Cupboards', 'Tables', 'Lamps'];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final h = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: h * 0.0481,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: w * 0.0438),
        scrollDirection: Axis.horizontal,
        itemCount: cats.length,
        separatorBuilder: (_, __) => SizedBox(width:  w * 0.0243),
        itemBuilder: (context, i) {
          final sel = i == selected;
          return ChoiceChip(
            label: Text(cats[i]),
            selected: sel,
            showCheckmark: false,
            onSelected: (_) => setState(() => selected = i),
            labelStyle: TextStyle(
              fontSize: 16,
              color: sel ? AppColors.white : AppColors.darkGray
            ),
            selectedColor: AppColors.darkGray,
            backgroundColor:AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.0486), )
          );
        },
      ),
    );
  }
}