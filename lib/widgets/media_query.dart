import 'package:flutter/cupertino.dart';

double mediaQueryLoginSignUpAnimation({
  required BuildContext context,
  double heightRatio = 2,
}) {
  MediaQueryData queryData = MediaQuery.of(context);
  double height = queryData.size.height / heightRatio;
  return height;
}

double mediaQueryWidth(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
  double width = queryData.size.width;
  return width;
}

double mediaQueryDevicePixelRatio(BuildContext context) {
  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;
  return devicePixelRatio;
}
