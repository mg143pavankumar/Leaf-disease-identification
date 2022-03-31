import 'package:flutter/material.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/src/widgets/small_text.dart';

class InstructionsSection extends StatelessWidget {
  const InstructionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.width20,
      ),
      height: Dimensions.height45 * 4.5,
      child: ScrollConfiguration(
        behavior: MaterialScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          children: [
            Card(
              elevation: 8,
              color: AppColors.kMain,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.kAccentLight,
                  child: Text(
                    '1',
                    style: TextStyle(color: AppColors.kWhite),
                  ),
                ),
                title: SmallText(
                  text:
                      "Capture a photo of an affected plant by tapping the camera button below.",
                  color: AppColors.kWhite,
                  size: Dimensions.font16,
                ),
              ),
            ),
            Card(
              elevation: 8,
              color: AppColors.kMain,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.kAccentLight,
                  child: Text(
                    '2',
                    style: TextStyle(color: AppColors.kWhite),
                  ),
                ),
                title: SmallText(
                  text:
                      "Please wait until for the model to identify the disease and give you a solution for the disease.",
                  color: AppColors.kWhite,
                  size: Dimensions.font16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
