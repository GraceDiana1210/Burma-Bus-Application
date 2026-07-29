import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RememberMeController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxBool rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    rememberMe.value = storage.read('rememberMe') ?? false;
  }

  void toggleRememberMe(bool value) {
    rememberMe.value = value;
    storage.write('rememberMe', value);
  }

  void saveUserSession(String email, String role) {
    storage.write('userEmail', email);
    storage.write('userRole', role);
  }

  String? getSavedRole() {
    return storage.read('userRole');
  }

  void clearUserSession() {
    storage.remove('userEmail');
    storage.remove('userRole');
    storage.write('rememberMe', false);
  }
}
