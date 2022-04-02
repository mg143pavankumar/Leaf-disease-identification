import 'package:get/get.dart';
import 'package:plant_disease_detector/data/languages.dart';
import 'package:translator/translator.dart';

class LangController extends GetxController {
  final translator = GoogleTranslator();

  String _diseaseName = "";
  String _possibleCauses = "";
  String _possibleSolution = "";
  String _languageCode = "en";

  bool _loading = false;

  List<dynamic> _options = Languages.options;
  List<dynamic> get options => _options;

  bool get loading => _loading;

  String get getDiseaseName => _diseaseName;
  String get getPossibleCauses => _possibleCauses;
  String get getPossibleSolution => _possibleSolution;
  String get getLanguageCode => _languageCode;

  void setLanguagecode(String data) {
    _languageCode = data;

    update();
  }

  void setDiseaseName(String data) {
    _diseaseName = data;

    update();
  }

  void setPossibleCauses(String data) {
    _possibleCauses = data;

    update();
  }

  void setPossibleSolution(String data) {
    _possibleSolution = data;

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
