import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/controller/auth_controller.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:intl/intl.dart';
import '../../controller/log_in_controller.dart';

class AuthenticationPage extends GetView<LoginController> {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: whiteColor,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Health Hero',
                  style: kBodyTextBodyAppTitleStyle(),
                ),
                const SizedBox(
                  height: 30,
                ),
                Image.asset('assets/images/health.png'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Join the health revolution and connect with peoples',
                  style:
                      kBodyTextBodyMediumStyle().copyWith(color: primaryColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Become the part of the community and learn how to fight with your disaese',
                  style: kBodyTextBodyMediumStyle()
                      .copyWith(color: greyColor, fontSize: 14),
                ),
                // const SizedBox(
                //   height: 28,
                // ),
                // Obx(
                //   () => SizedBox(
                //     width: double.infinity,
                //     child: DropdownButton<String>(
                //       elevation: 0,
                //       isExpanded: true,
                //       isDense: true,
                //       value: controller.selectedUser.value,
                //       onChanged: (String? newValue) {
                //         controller.updateSelectedUser(newValue!);
                //       },
                //       items: controller.users
                //           .map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Center(child: Text(value)),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () => controller.selectDate(context),
                    child: Obx(
                      () => Center(
                        child: Text(
                          controller.selectedDate.value != ''
                              ? 'DOB is : ${DateFormat('dd-MM-yyyy').format(DateTime.tryParse(controller.selectedDate.value)!)}'
                              : 'Select DOB',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whiteColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      if (controller.allOk()) {
                        controller.login();
                      } else {
                        showSnackBar(
                            "Select DOB to Sign In", primaryColor, whiteColor);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/Gicon.svg",
                          width: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    //mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
