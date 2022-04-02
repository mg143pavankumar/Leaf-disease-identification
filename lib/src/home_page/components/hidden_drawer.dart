import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_disease_detector/constants/constants.dart';
import 'package:plant_disease_detector/constants/dimensions.dart';
import 'package:plant_disease_detector/data/languages.dart';
import 'package:plant_disease_detector/helper/lang_controller.dart';
import 'package:plant_disease_detector/services/classify.dart';
import 'package:plant_disease_detector/services/disease_provider.dart';
import 'package:plant_disease_detector/services/hive_database.dart';
import 'package:plant_disease_detector/src/home_page/models/disease_model.dart';
import 'package:plant_disease_detector/src/suggestions_page/suggestions.dart';
import 'package:plant_disease_detector/src/widgets/big_text.dart';
import 'package:plant_disease_detector/src/widgets/small_text.dart';
import 'package:plant_disease_detector/src/widgets/spacing.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final translator = GoogleTranslator();

  LangController langController = Get.put(LangController());

  String selectedOption = "";

  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    // Hive service
    HiveService _hiveService = HiveService();

    final Classifier classifier = Classifier();
    late Disease _disease;

    return Scaffold(
      key: this._scaffoldKey,
      body: Container(
        color: Color.fromARGB(255, 2, 148, 46),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.height20,
          vertical: Dimensions.height45,
        ),
        child: langController.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpacing(Dimensions.height45),
                        InkWell(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (ctx) => _buildBottomSheet(ctx)),
                            child: GetBuilder<LangController>(
                              builder: (_) => SmallText(
                                text: langController.getSelectLanguage,
                                size: Dimensions.font16 * 1.2,
                                color: AppColors.kWhite,
                              ),
                            )),
                        verticalSpacing(Dimensions.height30),
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
                              GetBuilder<LangController>(
                                builder: (_) => SmallText(
                                  text: langController.getchooseImg,
                                  color: AppColors.kWhite,
                                  size: Dimensions.font16 * 1.2,
                                ),
                              )
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
                                GetBuilder<LangController>(
                                  builder: (_) => SmallText(
                                    text: langController.gettakePhoto,
                                    color: AppColors.kWhite,
                                    size: Dimensions.font16 * 1.2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  // bottomsheet container

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      height: Dimensions.height45 * 6,
      child: Column(
        children: [
          verticalSpacing(Dimensions.height10 * 2),
          GetBuilder<LangController>(builder: (_) {
            return BigText(
              text: langController.getSelectLanguage,
              color: AppColors.kMain,
            );
          }),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width20, vertical: Dimensions.height20),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: Dimensions.width20,
              children: langController.options
                  .map((option) => buildChip(option, context))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildChip(String option, BuildContext context) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedOption = option;
        });

        Get.back();

        switch (selectedOption) {
          case 'English':
            {
              langController.isLoading();

              var newData = await translator
                  .translate(langController.getSelectLanguage, to: "en");
              langController.setSelectLanguage(newData.toString());

              langController.setInstructions(
                  HomeScreenData.instruction1, HomeScreenData.instruction2);

              langController.setChooseImg(HomeScreenData.chooseImg);

              langController.setTakePhoto(HomeScreenData.takePhoto);

              langController.setNothingToShow(HomeScreenData.nothingToShow);

              langController.setTitles(
                  HomeScreenData.instructions, HomeScreenData.history);

              langController.notLoading();
            }
            break;
          case 'Hindi':
            {
              langController.isLoading();
              // var title =
              //     await translator.translate(langController.getTitle, to: "hi");
              // langController.setTitle(title.toString());

              var newData = await translator
                  .translate(langController.getSelectLanguage, to: "hi");
              langController.setSelectLanguage(newData.toString());

              var instructionData = await translator
                  .translate(langController.getInstruction1, to: "hi");

              var instruction1Data = await translator
                  .translate(langController.getInstruction2, to: "hi");
              langController.setInstructions(
                  instructionData.toString(), instruction1Data.toString());

              var chooseImg = await translator
                  .translate(langController.getchooseImg, to: "hi");
              langController.setChooseImg(chooseImg.toString());

              var takePhoto = await translator
                  .translate(langController.gettakePhoto, to: "hi");
              langController.setTakePhoto(takePhoto.toString());

              var nothingToShow = await translator
                  .translate(langController.getNothingToShow, to: "hi");
              langController.setNothingToShow(nothingToShow.toString());

              var instructionTitle = await translator
                  .translate(langController.getInstructionTitle, to: "hi");

              var historyTitle = await translator
                  .translate(langController.getHistoryTitle, to: "hi");

              langController.setTitles(
                  instructionTitle.toString(), historyTitle.toString());

              // var diseaseName = await translator
              //     .translate(langController.getDiseaseName, to: "hi");
              // langController.setDiseaseName(diseaseName.toString());

              langController.notLoading();
            }
            break;
          case 'Telugu':
            {
              langController.isLoading();
              // var title =
              //     await translator.translate(langController.getTitle, to: "te");
              // langController.setTitle(title.toString());

              var newData = await translator
                  .translate(langController.getSelectLanguage, to: "te");
              langController.setSelectLanguage(newData.toString());

              var instructionData = await translator
                  .translate(langController.getInstruction1, to: "te");

              var instruction1Data = await translator
                  .translate(langController.getInstruction2, to: "te");
              langController.setInstructions(
                  instructionData.toString(), instruction1Data.toString());

              var chooseImg = await translator
                  .translate(langController.getchooseImg, to: "te");
              langController.setChooseImg(chooseImg.toString());

              var takePhoto = await translator
                  .translate(langController.gettakePhoto, to: "te");
              langController.setTakePhoto(takePhoto.toString());

              var nothingToShow = await translator
                  .translate(langController.getNothingToShow, to: "te");
              langController.setNothingToShow(nothingToShow.toString());

              var instructionTitle = await translator
                  .translate(langController.getInstructionTitle, to: "te");

              var historyTitle = await translator
                  .translate(langController.getHistoryTitle, to: "te");

              langController.setTitles(
                  instructionTitle.toString(), historyTitle.toString());

              langController.notLoading();
            }
            break;
          case "Gujarati ":
            {
              langController.isLoading();

              // var title =
              //     await translator.translate(langController.getTitle, to: "gu");
              // langController.setTitle(title.toString());

              var newData = await translator
                  .translate(langController.getSelectLanguage, to: "gu");
              langController.setSelectLanguage(newData.toString());

              var instructionData = await translator
                  .translate(langController.getInstruction1, to: "gu");

              var instruction1Data = await translator
                  .translate(langController.getInstruction2, to: "gu");
              langController.setInstructions(
                  instructionData.toString(), instruction1Data.toString());

              var chooseImg = await translator
                  .translate(langController.getchooseImg, to: "gu");
              langController.setChooseImg(chooseImg.toString());

              var takePhoto = await translator
                  .translate(langController.gettakePhoto, to: "gu");
              langController.setTakePhoto(takePhoto.toString());

              var nothingToShow = await translator
                  .translate(langController.getNothingToShow, to: "gu");
              langController.setNothingToShow(nothingToShow.toString());

              var instructionTitle = await translator
                  .translate(langController.getInstructionTitle, to: "gu");

              var historyTitle = await translator
                  .translate(langController.getHistoryTitle, to: "gu");

              langController.setTitles(
                  instructionTitle.toString(), historyTitle.toString());

              langController.notLoading();
            }
            break;
          case "Marathi":
            {
              langController.isLoading();

              // var title =
              //     await translator.translate(langController.getTitle, to: "mr");
              // langController.setTitle(title.toString());

              var newData = await translator
                  .translate(langController.getSelectLanguage, to: "mr");
              langController.setSelectLanguage(newData.toString());

              var instructionData = await translator
                  .translate(langController.getInstruction1, to: "mr");

              var instruction1Data = await translator
                  .translate(langController.getInstruction2, to: "mr");
              langController.setInstructions(
                  instructionData.toString(), instruction1Data.toString());

              var chooseImg = await translator
                  .translate(langController.getchooseImg, to: "mr");
              langController.setChooseImg(chooseImg.toString());

              var takePhoto = await translator
                  .translate(langController.gettakePhoto, to: "mr");
              langController.setTakePhoto(takePhoto.toString());

              var nothingToShow = await translator
                  .translate(langController.getNothingToShow, to: "mr");
              langController.setNothingToShow(nothingToShow.toString());

              var instructionTitle = await translator
                  .translate(langController.getInstructionTitle, to: "mr");

              var historyTitle = await translator
                  .translate(langController.getHistoryTitle, to: "mr");

              langController.setTitles(
                  instructionTitle.toString(), historyTitle.toString());

              langController.notLoading();
            }
        }
      },
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
