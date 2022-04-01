import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/helper/lang_controller.dart';
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
          physics: BouncingScrollPhysics(),
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
                  title: GetBuilder<LangController>(
                    builder: (langController) => SmallText(
                      text: langController.getInstruction1,
                      color: AppColors.kWhite,
                      size: Dimensions.font16,
                    ),
                  )),
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
                title: GetBuilder<LangController>(
                  builder: (langController) => SmallText(
                    text: langController.getInstruction2,
                    color: AppColors.kWhite,
                    size: Dimensions.font16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
