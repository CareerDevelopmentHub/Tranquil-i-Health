import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_textfield/widget/social_text_field_controller.dart';
import 'package:get/get.dart';
import 'package:healthhero/src/widgets/custom_circular.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:healthhero/src/constants/global.dart';
import 'package:healthhero/src/screen/pages/createpost/controller/create_post_controller.dart';
import 'package:healthhero/src/theme/app_color.dart';
import 'package:healthhero/src/widgets/app_bar.dart';
import 'package:string_similarity/string_similarity.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  var controller = Get.find<CreatePostController>();
  String? filePath;
  String extractedText = '';

  Future<void> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    setState(() {
      filePath = result?.files.single.path;
      extractedText = '';
    });
  }

  checkPdf() async {
    final extracted = await extractTextFromPDF();
    String myString =
        '${controller.hospitalNameController.text}${controller.doctorName.text}${controller.duration.text}${controller.medicineController.text}${controller.symptoms.text}';

    if (StringSimilarity.compareTwoStrings(myString, extracted) > 0) {
      if (pickedFile != null) {
        uploadFile().then((url) {
          printMe('url of image picked', url);
          controller.postbutton(url);
          setState(() {
            showProgress = !showProgress;
          });
        });
      } else {
        CustomCircleLoading.cancelDialog();
        showSnackBar("choose img to post..", primaryColor, whiteColor);
      }
      //upload task
      //do other things here..
    } else {
      CustomCircleLoading.cancelDialog();
      showSnackBar(
          "Given Document is not legit and cannot be used to creating this post.",
          primaryColor,
          whiteColor);
    }
  }

  Future<String> extractTextFromPDF() async {
    // final File pdfFile = File(filePath!);
    PDFDoc doc = await PDFDoc.fromPath(filePath!);
    String docText = await doc.text;
    return docText;
  }

  PlatformFile? pickedFile;
  handleFileUpload() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        pickedFile = result.files.first;
      });
    } else {
      showSnackBar('No Image selected', blackColor, whiteColor);
    }
  }

  UploadTask? uploadTask;
  bool showProgress = false;

  Future uploadFile() async {
    setState(() {
      showProgress = !showProgress;
    });
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    printMe('url', urlDownload);
    return urlDownload;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CreatePostController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: CustomAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                backgroundColor: primaryForegroundColor,
              ),
              onPressed: () {
                CustomCircleLoading.showDialog();
                if (pickedFile != null &&
                    filePath != null &&
                    controller.doctorName.text.isNotEmpty &&
                    controller.duration.text.isNotEmpty &&
                    controller.medicineController.text.isNotEmpty &&
                    controller.symptoms.text.isNotEmpty) {
                  checkPdf();
                } else {
                  CustomCircleLoading.cancelDialog();
                  showSnackBar("Choose Document/blanks to Post", primaryColor,
                      whiteColor);
                }
              },
              child: Text('Post', style: kBodyTextSubtitleStyle()),
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    child: CachedNetworkImage(
                      imageUrl: controller.getUserProfile(),
                      width: 45,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.getUsername ?? 'L',
                          style: kBodyTextSubtitleStyle1()),
                      Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            value: controller.selectedList.value,
                            items: controller.itemList
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                          style: kBodyTextSubtitleStyle()
                                              .copyWith(color: blackColor)),
                                    ))
                                .toList(),
                            onChanged: ((value) =>
                                controller.changeIdx(value.toString())),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 80,
                child: DefaultSocialTextFieldController(
                  detectionPresentationMode:
                      DetectionPresentationMode.above_text_field,
                  focusNode: FocusNode(),
                  //scrollController: _scrollController,
                  textEditingController: controller.postController,
                  detectionBuilders: const {
                    // DetectedType.mention: (context) => mentionContent(height),
                    // DetectedType.hashtag: (context) => hashtagContent(height),
                    // DetectedType.url: (context) => urlContent(height)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          cursorColor: primaryForegroundColor,
                          scrollPhysics:
                              const ClampingScrollPhysics(), //Use this for unnecessary scroll bounces
                          // scrollController: _scrollController,
                          focusNode: FocusNode(),
                          controller: controller.hospitalNameController,
                          // expands: true,
                          maxLines: 2,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusColor: primaryColor,
                              hintText: "Which Hospital??",
                              hintStyle: kBodyTextSubtitleStyle1()
                                  .copyWith(color: greyColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultSocialTextFieldController(
                  detectionPresentationMode:
                      DetectionPresentationMode.above_text_field,
                  focusNode: FocusNode(),
                  //scrollController: _scrollController,
                  textEditingController: controller.postController,
                  detectionBuilders: const {
                    // DetectedType.mention: (context) => mentionContent(height),
                    // DetectedType.hashtag: (context) => hashtagContent(height),
                    // DetectedType.url: (context) => urlContent(height)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          cursorColor: primaryForegroundColor,
                          scrollPhysics:
                              const ClampingScrollPhysics(), //Use this for unnecessary scroll bounces
                          // scrollController: _scrollController,
                          focusNode: FocusNode(),
                          controller: controller.doctorName,
                          // expands: true,
                          maxLines: 2,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusColor: primaryColor,
                              hintText: "Who was your doctor??",
                              hintStyle: kBodyTextSubtitleStyle1()
                                  .copyWith(color: greyColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultSocialTextFieldController(
                  detectionPresentationMode:
                      DetectionPresentationMode.above_text_field,
                  focusNode: FocusNode(),
                  //scrollController: _scrollController,
                  textEditingController: controller.postController,
                  detectionBuilders: const {
                    // DetectedType.mention: (context) => mentionContent(height),
                    // DetectedType.hashtag: (context) => hashtagContent(height),
                    // DetectedType.url: (context) => urlContent(height)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          cursorColor: primaryForegroundColor,
                          scrollPhysics:
                              const ClampingScrollPhysics(), //Use this for unnecessary scroll bounces
                          // scrollController: _scrollController,
                          focusNode: FocusNode(),
                          controller: controller.duration,
                          // expands: true,
                          maxLines: 2,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusColor: primaryColor,
                              hintText: "What is your duration??",
                              hintStyle: kBodyTextSubtitleStyle1()
                                  .copyWith(color: greyColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: DefaultSocialTextFieldController(
                  detectionPresentationMode:
                      DetectionPresentationMode.above_text_field,
                  focusNode: FocusNode(),
                  //scrollController: _scrollController,
                  textEditingController: controller.postController,
                  detectionBuilders: const {
                    // DetectedType.mention: (context) => mentionContent(height),
                    // DetectedType.hashtag: (context) => hashtagContent(height),
                    // DetectedType.url: (context) => urlContent(height)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          cursorColor: primaryForegroundColor,
                          scrollPhysics:
                              const ClampingScrollPhysics(), //Use this for unnecessary scroll bounces
                          // scrollController: _scrollController,
                          focusNode: FocusNode(),
                          controller: controller.medicineController,
                          // expands: true,
                          maxLines: 2,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusColor: primaryColor,
                              hintText: "Which medicine you have taken??",
                              hintStyle: kBodyTextSubtitleStyle1()
                                  .copyWith(color: greyColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 230,
                child: DefaultSocialTextFieldController(
                  detectionPresentationMode:
                      DetectionPresentationMode.above_text_field,
                  focusNode: FocusNode(),
                  //scrollController: _scrollController,
                  textEditingController: controller.postController,
                  detectionBuilders: const {
                    // DetectedType.mention: (context) => mentionContent(height),
                    // DetectedType.hashtag: (context) => hashtagContent(height),
                    // DetectedType.url: (context) => urlContent(height)
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          cursorColor: primaryForegroundColor,
                          scrollPhysics:
                              const ClampingScrollPhysics(), //Use this for unnecessary scroll bounces
                          // scrollController: _scrollController,
                          focusNode: FocusNode(),
                          controller: controller.symptoms,
                          // expands: true,
                          maxLines: 10,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusColor: primaryColor,
                              hintText: "Symptoms and Diagnosis/ Summary",
                              hintStyle: kBodyTextSubtitleStyle1()
                                  .copyWith(color: greyColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera),
                  ),
                  IconButton(
                    onPressed: () {
                      handleFileUpload();
                    },
                    icon: const Icon(Icons.photo),
                  ),
                  IconButton(
                    onPressed: () {
                      pickPDFFile();
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                  ),
                ],
              ),
              if (pickedFile != null)
                SizedBox(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Image.file(
                        File(pickedFile!.path!),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              if (showProgress)
                StreamBuilder<TaskSnapshot>(
                    stream: uploadTask?.snapshotEvents,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data!;
                        double progress =
                            data.bytesTransferred / data.totalBytes;
                        return SizedBox(
                          height: 30,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 20,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Color(0xff00ff00)),
                                    backgroundColor: const Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${(100 * progress).roundToDouble()}',
                                  style: const TextStyle(color: whiteColor),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }))
            ],
          ),
        ),
      ),
    );
  }
}
