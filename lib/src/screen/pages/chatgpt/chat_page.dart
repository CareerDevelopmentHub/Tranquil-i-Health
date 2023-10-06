import 'dart:developer';
import 'package:bard_api/bard_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/screen/helper/firebase_helper.dart';
import 'package:healthhero/src/screen/pages/chatgpt/pallate.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'feature_box.dart';

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage({super.key});

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
    getApi();
  }

  String sessionID =
      "Wwgnq8ID5Lmg-p4Par5YUhrmFY6HL_u0N1cVYErV1Qfjytm7cMZip_Pr1spPKhslw89Oqw.";

  Future<void> getApi() async {
    return firestore.collection('api').doc('bard').get().then((value) {
      sessionID = value["id"];
    });
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(
        onResult: onSpeechResult, listenFor: const Duration(seconds: 10));
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Bard AI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // chat bubble
            Visibility(
              visible: generatedImageUrl == null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                  top: 30,
                ),
                decoration: BoxDecoration(
                  color: primaryForegroundColor,
                  borderRadius: BorderRadius.circular(20).copyWith(
                    topRight: Radius.zero,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    generatedContent == null
                        ? 'I am Google Bard AI, Here to boost your productivity..'
                        : generatedContent!,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: generatedContent == null ? 22 : 18,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 10, left: 22),
                child: const Text(
                  'Here are some features',
                  style: TextStyle(
                    color: ColorClass.mainFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // features list
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: const [
                  CustomBox(
                    color: Color(0xff4285F4),
                    Hcolor: whiteColor,
                    Dcolor: whiteColor,
                    headerText: 'BARD AI',
                    descriptionText:
                        'A smarter way to stay updated and informed with Google Bard AI',
                  ),
                  CustomBox(
                    Hcolor: whiteColor,
                    Dcolor: whiteColor,
                    color: Color(0xffDB4437),
                    headerText: 'Smart Voice Assistant',
                    descriptionText:
                        'Get your query solved with voice Assistant',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4285F4),
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          LinearProgressIndicator(
                            color: Color(0xffF4B400),
                          ),
                          Text('Recognizing Text..'),
                        ],
                      ),
                    ));
            try {
              final bard = ChatBot(sessionId: sessionID);
              final speech = await bard.ask(lastWords);
              log(speech.toString());
              final result = speech["content"];
              //final speech = await openAIService.isArtPromptAPI(lastWords);
              generatedContent = result;
              Get.back();
              await systemSpeak(result);
              await stopListening();
            } catch (e) {
              Get.back();
              showSnackBar("Session ID Expired..", primaryColor, whiteColor);
            }
          } else {
            initSpeechToText();
          }
        },
        child: Icon(
          speechToText.isListening ? Icons.stop : Icons.mic,
        ),
      ),
    );
  }
}
