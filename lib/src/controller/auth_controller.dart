import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/screen/pages/home_screen.dart';

class AuthController extends GetxController {
  late GoogleSignIn googleSignIn;
  Rx<bool> isSignedIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onReady() {
    googleSignIn = GoogleSignIn();
    ever(isSignedIn, handleAuthStateChanged);
    isSignedIn.value = firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignedIn.value = event != null;
    });
    super.onReady();
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.offAll(() => const HomePage());
      sharedPreferences.setString('logged', 'yes');
    }
  }
}
