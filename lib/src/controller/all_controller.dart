import 'package:get/get.dart';
import 'package:healthhero/src/controller/auth_controller.dart';
import 'package:healthhero/src/screen/pages/createpost/controller/create_post_controller.dart';

import '../screen/pages/activities/controller/activity_controller.dart';
import '../screen/pages/controller/feed_controller.dart';
import '../screen/pages/controller/home_controller.dart';
import '../screen/pages/feed/controller/joined_group_controller.dart';
import '../screen/pages/profile/controller/profile_controller.dart';
import '../screen/pages/search/controller/search_controller.dart';
import 'handle_onboarding_controller.dart';
import 'log_in_controller.dart';

class AllBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HandleOnBoardingController());
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => FeedController(), fenix: true);
    Get.lazyPut(() => CreatePostController(), fenix: true);
    Get.lazyPut(() => JoinedGroupController(), fenix: true);
    Get.lazyPut(() => SearchController(), fenix: true);
    Get.lazyPut(() => ActivityController(), fenix: true);
    //Get.lazyPut(() => LoginController());
  }
}
