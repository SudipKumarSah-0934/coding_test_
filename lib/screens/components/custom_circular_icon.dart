import 'package:coding_test_/screens/components/custom_text.dart';
import 'package:flutter/material.dart';

class CustomCircularIcon extends StatelessWidget {
  const CustomCircularIcon(
      {super.key, required this.categoryIcon, required this.categoryType});
  final IconData categoryIcon;
  final String categoryType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Color.fromARGB(255, 234, 235, 232),
            child: IconButton(
              icon: Icon(
                categoryIcon,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomText(
            text: categoryType,
            size: 10.0,
            textColor: Color.fromARGB(255, 133, 131, 131),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
