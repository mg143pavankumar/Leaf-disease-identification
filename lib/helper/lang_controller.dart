import 'package:get/get.dart';
import 'package:plant_disease_detector/data/languages.dart';
import 'package:translator/translator.dart';

class LangController extends GetxController {
  final translator = GoogleTranslator();

  bool _loading = false;

  List<dynamic> _options = Languages.options;
  List<dynamic> get options => _options;

  bool get loading => _loading;

  void isLoading() {
    _loading = true;

    update();
  }

  void notLoading() {
    _loading = false;

    update();
  }
}
