import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/data/languages.dart';
import 'package:plant_disease_detector/helper/lang_controller.dart';
import 'package:plant_disease_detector/src/widgets/big_text.dart';
import 'package:plant_disease_detector/src/widgets/spacing.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String? selectedOption = "";

  LangController langController = Get.put(LangController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45 * 7,
      child: Column(
        children: [
          verticalSpacing(Dimensions.height10 * 2),
          GetBuilder<LangController>(builder: (_) {
            return BigText(
              text: langController.newData,
              color: AppColors.kMain,
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20, vertical: Dimensions.height20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: Dimensions.width20,
              children:
                  Languages.options.map((option) => buildChip(option)).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildChip(String option) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () => setState(() {
        selectedOption = option;

        if (selectedOption == "Hindi") {
          // langController.setData(newData.toString());
        }
      }),
      child: Chip(
        backgroundColor: isSelected ? AppColors.kMain : AppColors.kWhite,
        shape: StadiumBorder(
            side: BorderSide(
          color: AppColors.kMain,
        )),
        label: Text(
          option,
          style: TextStyle(
            color: isSelected ? AppColors.kWhite : AppColors.kMain,
            fontSize: Dimensions.font16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
