import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/master_color.dart';

abstract class BaseAppColorProps {
  final Color? main;
  final Color? hover;
  final Color? pressed;
  final Color? surface;
  final Color? border;
  final Color? content;
  final Color? focus;

  BaseAppColorProps({
    this.main,
    this.hover,
    this.pressed,
    this.surface,
    this.border,
    this.content,
    this.focus,
  });
}

class PrimaryNewColor implements BaseAppColorProps {
  PrimaryNewColor();

  @override
  Color get main => BrandColor.color600;

  @override
  Color get border => BrandColor.color200;

  @override
  Color get content => GrayColor.color10;

  @override
  Color get hover => BrandColor.color700;

  @override
  Color get pressed => BrandColor.color800;

  @override
  Color get surface => BrandColor.color100;

  @override
  Color get focus => BrandColor.color600.withOpacity(0.3);
}

class DangerNewColor implements BaseAppColorProps {
  DangerNewColor();

  @override
  Color get border => RedColor.color100;

  @override
  Color get content => GrayColor.color10;

  @override
  Color get focus => RedColor.color600.withOpacity(0.3);

  @override
  Color get hover => RedColor.color700;

  @override
  Color get main => RedColor.color600;

  @override
  Color get pressed => RedColor.color900;

  @override
  Color get surface => RedColor.color50;
}

class WarningNewColor implements BaseAppColorProps {
  WarningNewColor();

  @override
  Color get border => OrangeColor.color200;

  @override
  Color get content => GrayColor.color10;

  @override
  Color get focus => OrangeColor.color600.withOpacity(0.3);

  @override
  Color get hover => OrangeColor.color700;

  @override
  Color get main => OrangeColor.color600;

  @override
  Color get pressed => OrangeColor.color800;

  @override
  Color get surface => OrangeColor.color50;
}

class SuccessNewColor implements BaseAppColorProps {
  SuccessNewColor();

  @override
  Color get border => GreenColor.color200;

  @override
  Color get content => GrayColor.color10;

  @override
  Color get focus => GreenColor.color600.withOpacity(0.3);

  @override
  Color get hover => GreenColor.color700;

  @override
  Color get main => GreenColor.color600;

  @override
  Color get pressed => GreenColor.color800;

  @override
  Color get surface => GreenColor.color50;
}

class InfoNewColor implements BaseAppColorProps {
  InfoNewColor();

  @override
  Color get border => BlueColor.color200;

  @override
  Color get content => GrayColor.color10;

  @override
  Color get focus => BlueColor.color600.withOpacity(0.3);

  @override
  Color get hover => BlueColor.color700;

  @override
  Color get main => BlueColor.color600;

  @override
  Color get pressed => BlueColor.color800;

  @override
  Color get surface => BlueColor.color50;
}

class YellowBaseColor implements BaseAppColorProps {
  const YellowBaseColor();

  @override
  Color get border => YellowColor.color200;

  @override
  Color get content => YellowColor.color100;

  @override
  Color get focus => YellowColor.color100;

  @override
  Color get hover => YellowColor.color100;

  @override
  Color get main => YellowColor.color100;

  @override
  Color get pressed => YellowColor.color100;

  @override
  Color get surface => YellowColor.color50;

}

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

class BackgroundColor {
  BackgroundColor._();

  static const primary = Colors.white;
  static const secondary = GrayColor.color20;
  static const tertiary = GrayColor.color30;
  static const disabled = GrayColor.color40;
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
