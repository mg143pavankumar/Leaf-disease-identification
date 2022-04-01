import 'package:get/get.dart';
import 'package:translator/translator.dart';

class LangController extends GetxController {
  final translator = GoogleTranslator();

  String _title = "Identification of Leaf Disease by Team Introspectors";

  String _selectLanguage = "Choose a language";

  String _instruction1 =
      "Capture a photo of an affected plant by tapping the camera button below.";

  String _instruction2 =
      "Please wait until for the model to identify the disease and give you a solution for the disease.";

  String _chooseImg = "Choose Image";
  String _takePhoto = "Take a Photo";

  bool _loading = false;

  String get getTitle => _title;
  String get getSelectLanguage => _selectLanguage;
  String get getInstruction1 => _instruction1;
  String get getInstruction2 => _instruction2;
  String get getchooseImg => _chooseImg;
  String get gettakePhoto => _takePhoto;

  bool get loading => _loading;

  void setTitle(String data) async {
    _title = data;
    update();
  }

  void setSelectLanguage(String data) async {
    _selectLanguage = data;

    update();
  }

  void setInstruction1(String data) {
    _instruction1 = data;
    update();
  }

  void setInstruction2(String data) {
    _instruction2 = data;
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

  void isLoading() {
    _loading = true;

    update();
  }

  void notLoading() {
    _loading = false;

    update();
  }
}
