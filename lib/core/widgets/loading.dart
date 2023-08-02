import 'package:flutter/material.dart';

import '../constant/colors/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
      ),
    );
  }
}