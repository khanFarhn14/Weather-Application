import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const dominant = Color(0xffE2EAF2);
const secondary = Color(0xff1E1E1E);


TextStyle regular(){
  return TextStyle(
    fontFamily: 'InterSemiBold',
    fontSize: 16.sp,
    color: secondary,
  );
}

TextStyle semiRegular(){
  return TextStyle(
    fontFamily: 'InterRegular',
    fontSize: 12.sp,
    color: secondary,
  );
}

TextStyle bigBold(){
  return TextStyle(
    fontFamily: 'InterBlack',
    fontSize: 72.sp,
    color: secondary,
  );
}