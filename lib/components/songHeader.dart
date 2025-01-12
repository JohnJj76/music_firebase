import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SongPageHeader extends StatelessWidget {
  const SongPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/icons/big_logo.svg",
          width: 30,
        ),
        SizedBox(width: 10),
        Text(
          "JOTTA",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Poppins"),
        )
      ],
    );
  }
}
