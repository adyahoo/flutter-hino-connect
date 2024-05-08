// import 'package:flutter/material.dart';
// import 'package:hino_driver_app/infrastructure/theme/app_color.dart';

part of 'widgets.dart';

class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onSelect;

  CustomRadioButton({required this.isSelected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? PrimaryColor.main : BorderColor.disabled,
            width: 1,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 10, 
                  height: 10, 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PrimaryColor.main,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}