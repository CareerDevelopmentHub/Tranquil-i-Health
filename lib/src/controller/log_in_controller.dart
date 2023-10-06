import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthhero/src/controller/auth_controller.dart';
import 'package:healthhero/src/service/firebase.dart';
import 'package:healthhero/src/widgets/custom_circular.dart';

class LoginController extends GetxController {
  AuthController authController = Get.find<AuthController>();

  @override
  void onClose() {
    AuthController().dispose();
    LoginController().dispose();
  }

  late RxString selectedDate = ''.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate.value = pickedDate.toIso8601String();
    }
  }

  RxString selectedUser = 'Patient'.obs;
  List<String> users = ['Patient', 'Doctor'];

  updateSelectedUser(String newVal) {
    selectedUser.value = newVal;
  }

  bool allOk() {
    return selectedDate.value != '';
  }

  void login() async {
    CustomCircleLoading.showDialog();
    GoogleSignInAccount? googleSignInAccount =
        await authController.googleSignIn.signIn();
    if (googleSignInAccount == null) {
      CustomCircleLoading.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final UserCredential credential = await authController.firebaseAuth
          .signInWithCredential(oAuthCredential)
          .then((value) => saveUserInformationToFirebaseAndLocally(
              googleSignInAccount.displayName,
              googleSignInAccount.email,
              googleSignInAccount.photoUrl,
              value.user!.uid,
              googleSignInAccount.email.contains('@gmail.com')
                  ? "patient"
                  : "doctor",
              selectedDate.value));

      if (kDebugMode) {
        print(oAuthCredential);
        print(credential);
        print(googleSignInAccount);
      }
      CustomCircleLoading.cancelDialog();
    }
  }
}

saveUserInformationToFirebaseAndLocally(String? name, String email,
    String? photourl, String id, String role, String dob) {
  FirebaseClass.uploadUserProfileAndSaveLocally(
      name ?? 'user', photourl ?? '', email, id, role, dob);
}
