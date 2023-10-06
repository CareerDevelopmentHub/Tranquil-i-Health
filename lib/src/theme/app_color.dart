import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color primaryForegroundColor = Color(0XFFC489DF);
const Color primaryColor = Color(0XFF191A23);
const Color inactiveIconColor = Color(0XFFAEAEB3);
const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;
const Color greyColor = Color(0xFFC4C4C4);
const Color redColor = Colors.red;
const Color greenColor = Colors.green;
Color lightGreenColor = const Color(0xFF1CC26F).withOpacity(0.5);
const Color blueColor = Color(0xff3D49EE);

TextStyle kTitleTextStyle() {
  return GoogleFonts.montserrat(color: Colors.white, fontSize: 12.sp);
}

TextStyle kBodyTextTitleStyle() {
  return GoogleFonts.montserrat(
    color: Colors.black,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
  );
}

TextStyle kProfileTextStyle() {
  return GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    color: blackColor,
  );
}

TextStyle kBodyTextSubtitleStyle() {
  return GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );
}

TextStyle kBodyTextSubtitleStyle1() {
  return GoogleFonts.montserrat(
    color: blackColor,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
  );
}

TextStyle kBodyTextSubtitle2Style() {
  return GoogleFonts.montserrat(
    color: blueColor,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
  );
}

TextStyle kBodyTextBodyMediumStyle() {
  return GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );
}

TextStyle kBodyTextBodyAppTitleStyle() {
  return GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
}
