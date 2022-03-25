import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/services/classify.dart';
import 'package:plant_disease_detector/services/disease_provider.dart';
import 'package:plant_disease_detector/services/hive_database.dart';
import 'package:plant_disease_detector/src/home_page/models/disease_model.dart';
import 'package:plant_disease_detector/src/suggestions_page/suggestions.dart';
import 'package:plant_disease_detector/src/widgets/small_text.dart';
import 'package:plant_disease_detector/src/widgets/spacing.dart';
import 'package:provider/provider.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    // Hive service
    HiveService _hiveService = HiveService();

    final Classifier classifier = Classifier();
    late Disease _disease;

    return Container(
      color: Color.fromARGB(255, 2, 148, 46),
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
                text: "version: 1.1",
                fontStyle: FontStyle.italic,
                size: Dimensions.font16 * 1.2,
                color: AppColors.kWhite,
              )
            ],
          ),
          Container(
            height: Dimensions.height45 * 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    late double _confidence;
                    await classifier
                        .getDisease(ImageSource.gallery)
                        .then((value) {
                      _disease = Disease(
                          name: value![0]["label"],
                          imagePath: classifier.imageFile.path);

                      _confidence = value[0]['confidence'];
                    });
                    // Check confidence
                    if (_confidence > 0.8) {
                      // Set disease for Disease Service
                      _diseaseService.setDiseaseValue(_disease);

                      // Save disease
                      _hiveService.addDisease(_disease);

                      Navigator.restorablePushNamed(
                        context,
                        Suggestions.routeName,
                      );
                    } else {
                      // Display unsure message

                    }
                  },
                  child: Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.file,
                        color: AppColors.kWhite,
                      ),
                      horizontalSpacing(Dimensions.width15),
                      SmallText(
                        text: "Choose image",
                        color: AppColors.kWhite,
                        size: Dimensions.font20,
                      ),
                    ],
                  ),
                ),
                verticalSpacing(Dimensions.height20),
                InkWell(
                  onTap: () async {
                    late double _confidence;

                    await classifier
                        .getDisease(ImageSource.camera)
                        .then((value) {
                      _disease = Disease(
                          name: value![0]["label"],
                          imagePath: classifier.imageFile.path);

                      _confidence = value[0]['confidence'];
                    });

                    // Check confidence
                    if (_confidence > 0.8) {
                      // Set disease for Disease Service
                      _diseaseService.setDiseaseValue(_disease);

                      // Save disease
                      _hiveService.addDisease(_disease);

                      Navigator.restorablePushNamed(
                        context,
                        Suggestions.routeName,
                      );
                    } else {
                      // Display unsure message

                    }
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.camera,
                          color: AppColors.kWhite,
                        ),
                        horizontalSpacing(Dimensions.width15),
                        SmallText(
                          text: "Take photo",
                          color: AppColors.kWhite,
                          size: Dimensions.font20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
