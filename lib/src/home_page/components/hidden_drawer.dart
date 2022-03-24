import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/src/widgets/small_text.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 148, 46),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height20,
          vertical: Dimensions.height45,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/plant.png",
                  height: Dimensions.height45 * 1.2,
                ),
                SmallText(
                  text: "version: 1.0",
                  fontStyle: FontStyle.italic,
                  size: Dimensions.font16 * 1.2,
                  color: AppColors.kWhite,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
