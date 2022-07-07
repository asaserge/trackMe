import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trackcam/views/home_screen.dart';

class AuthController extends GetxController {

  RxBool isObscured = true.obs;
  RxBool isLoading = false.obs;
  RxBool isOn = Get.isDarkMode.obs;
  var lang = Get.deviceLocale!.languageCode.obs;


}