import 'package:flutter/material.dart';

import '../../../core/constant/colors/colors.dart';
import '../../../core/constant/styles/styles.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          size: 35,
          Icons.short_text_sharp,
          color: Colors.transparent,
        ),
        Expanded(
          child: Center(
            child: Text(
              'TODO',
              style: TextStyles.textViewRegular20.copyWith(color: mainColor),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  purpleColor.withOpacity(0.6),
                  orangeColor.withOpacity(0.6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Icon(
              size: 35,
              Icons.short_text_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
