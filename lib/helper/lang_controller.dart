import 'package:get/get.dart';
import 'package:plant_disease_detector/data/languages.dart';
import 'package:translator/translator.dart';

class LangController extends GetxController {
  final translator = GoogleTranslator();

  String _title = "Leaf Disease Identification by Team Introspectors";

  String _selectLanguage = "Choose a language";

  String _instruction1 =
      "Capture a photo of an affected plant by tapping the camera button below.";

  String _instruction2 =
      "Please wait until for the model to identify the disease and give you a solution for the disease.";

  String _chooseImg = "Choose Image";
  String _takePhoto = "Take a Photo";
  String _nothingToShow = "Nothing to show";
  String _instructionTitle = "Instructions";
  String _histroyTitle = "Histroy";
  String _diseaseName = "";

  bool _loading = false;

  List<dynamic> _options = Languages.options;

  String get getTitle => _title;
  String get getSelectLanguage => _selectLanguage;
  String get getInstruction1 => _instruction1;
  String get getInstruction2 => _instruction2;
  String get getchooseImg => _chooseImg;
  String get gettakePhoto => _takePhoto;
  String get getNothingToShow => _nothingToShow;
  String get getInstructionTitle => _instructionTitle;
  String get getHistoryTitle => _histroyTitle;
  String get getDiseaseName => _diseaseName;

  List<dynamic> get options => _options;

  bool get loading => _loading;

  void setTitle(String data) async {
    _title = data;
    update();
  }

  void setSelectLanguage(String data) async {
    _selectLanguage = data;

    update();
  }

  void setInstructions(String instruction1, String instruction2) {
    _instruction1 = instruction1;
    _instruction2 = instruction2;
    update();
  }

  void setChooseImg(String data) {
    _chooseImg = data;
    update();
  }

  void setTakePhoto(String data) {
    _takePhoto = data;
    update();
  }

  void setOptions(List<dynamic> options) {
    _options = options;

    update();
  }

  void setNothingToShow(String data) {
    _nothingToShow = data;

    update();
  }

  void setTitles(String instructionTitle, String historyTitle) {
    _instructionTitle = instructionTitle;
    _histroyTitle = historyTitle;

    update();
  }

  void setDiseaseName(String data) {
    _diseaseName = data;

    update();
  }

  void isLoading() {
    _loading = true;

    update();
  }

  void notLoading() {
    _loading = false;

    update();
  }
}
