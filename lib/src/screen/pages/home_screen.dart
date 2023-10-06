import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/screen/pages/chatgpt/chat_page.dart';
import 'package:healthhero/src/screen/pages/controller/home_controller.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:healthhero/src/utils/fab_container.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => PageTransitionSwitcher(
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: controller.pages[controller.index.value]['page'],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: primaryColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              for (Map item in controller.pages)
                item['index'] == 2
                    ? buildPlusButton()
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: item['index'] == controller.index.value
                            ? Material(
                                shape:
                                    const CircleBorder(side: BorderSide.none),
                                elevation: 4,
                                child: CircleAvatar(
                                  backgroundColor:
                                      primaryColor.withOpacity(0.8),
                                  // height: 45,
                                  // width: 40,
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   color:
                                  //       item['index'] != controller.index.value
                                  //           ? Colors.black
                                  //           : blackColor,
                                  //  ),
                                  child: IconButton(
                                    icon: Center(
                                      child: Icon(
                                        item['icon'],
                                        color: whiteColor,
                                        size: 25.0,
                                      ),
                                    ),
                                    onPressed: () =>
                                        navigationTapped(item['index']),
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  item['icon'],
                                  color: const Color(0xFFC4C4C4),
                                  size: 25.0,
                                ),
                                onPressed: () =>
                                    navigationTapped(item['index']),
                              ),
                      ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              backgroundColor: primaryForegroundColor,
              child: const Icon(Icons.mic),
              onPressed: () {
                Get.to(() => const ChatScreenPage());
              }),
        ),
      ),
      // floatingActionButton: ZoomIn(
      //   delay: Duration(milliseconds: start + 3 * delay),
      //   child: FloatingActionButton(
      //     backgroundColor: Pallete.firstSuggestionBoxColor,
      //     onPressed: () async {
      //       if (await speechToText.hasPermission &&
      //           speechToText.isNotListening) {
      //         await startListening();
      //       } else if (speechToText.isListening) {
      //         final speech = await openAIService.isArtPromptAPI(lastWords);
      //         if (speech.contains('https')) {
      //           generatedImageUrl = speech;
      //           generatedContent = null;
      //           setState(() {});
      //         } else {
      //           generatedImageUrl = null;
      //           generatedContent = speech;
      //           setState(() {});
      //           await systemSpeak(speech);
      //         }
      //         await stopListening();
      //       } else {
      //         initSpeechToText();
      //       }
      //     },
      //     child: Icon(
      //       speechToText.isListening ? Icons.stop : Icons.mic,
      //     ),
      //   ),
      // ),
    );
  }

  buildPlusButton() {
    return const SizedBox(
      height: 45.0,
      width: 45.0,
      // ignore: missing_required_param
      child: AddIconContainer(
        icon: Ionicons.add,
        mini: true,
      ),
    );
  }

  void navigationTapped(int page) {
    controller.changeIndex(page);
  }
}
