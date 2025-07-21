import 'package:authentication_practice_project/feature/auth/controller/continue_with_google_controller.dart';
import 'package:authentication_practice_project/feature/auth/controller/create_account_controller.dart';
import 'package:authentication_practice_project/feature/auth/controller/sign_in_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CreateAccountController());
    Get.put(SignInController());
    Get.put(ContinueWithGoogleController());
  }

}