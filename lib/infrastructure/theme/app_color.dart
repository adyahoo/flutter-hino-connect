import 'package:hino_driver_app/infrastructure/theme/master_color.dart';

class PrimaryColor {
  PrimaryColor._();

  static const main = BrandColor.color600;
  static const hover = BrandColor.color700;
  static const pressed = BrandColor.color800;
  static const surface = BrandColor.color100;
  static const border = BrandColor.color200;
  static const content = GrayColor.color10;
  static final focus = BrandColor.color600.withOpacity(0.3);
}

class TextColor {
  TextColor._();

  static const primary = GrayColor.color100;
  static const secondary = GrayColor.color90;
  static const tertiary = GrayColor.color80;
  static const placeholder = GrayColor.color70;
  static const error = RedColor.color600;
  static const helper = GrayColor.color60;
  static const disabled = GrayColor.color50;
}

class BorderColor {
  BorderColor._();

  static const primary = GrayColor.color30;
  static const secondary = GrayColor.color40;
  static const disabled = GrayColor.color50;
  static const error = RedColor.color600;
}

class IconColor {
  IconColor._();

  static const primary = GrayColor.color100;
  static const secondary = GrayColor.color70;
  static const disabled = GrayColor.color50;
}

class ErrorColor {
  ErrorColor._();

  static const main = RedColor.color600;
  static const hover = RedColor.color700;
  static const pressed = RedColor.color900;
  static const surface = RedColor.color50;
  static const border = RedColor.color100;
  static const content = GrayColor.color10;
}

class SuccesColor {
  SuccesColor._();

  static const main = GreenColor.color600;
  static const hover = GreenColor.color700;
  static const pressed = GreenColor.color800;
  static const surface = GreenColor.color50;
  static const border = GreenColor.color200;
  static const content = GrayColor.color10;
}

class InfoColor {
  InfoColor._();

  static const main = BlueColor.color600;
  static const hover = BlueColor.color700;
  static const pressed = BlueColor.color800;
  static const surface = BlueColor.color50;
  static const border = BlueColor.color200;
  static const content = GrayColor.color10;
}

class WarningColor {
  WarningColor._();

  static const main = OrangeColor.color600;
  static const hover = OrangeColor.color700;
  static const pressed = OrangeColor.color800;
  static const surface = OrangeColor.color50;
  static const border = OrangeColor.color200;
  static const content = GrayColor.color10;
}
