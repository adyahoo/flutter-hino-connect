// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
// import 'package:hino_driver_app/presentation/widgets/widgets.dart';

part of '../widgets.dart';

enum BottomSheetType { confirmation }

class CustomBottomSheet extends StatelessWidget {
  final BottomSheetType type;
  final String title;
  final String description;
  final VoidCallback firstButtonOnClick;
  final VoidCallback secondButtonOnClick;

  const CustomBottomSheet({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.firstButtonOnClick,
    required this.secondButtonOnClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BottomSheetType.confirmation:
        return _buildConfirmationBottomSheet(context);

      // Add more cases as needed for other types of bottom sheets below

      default:
        return Container();
    }
  }

  Widget _buildConfirmationBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      width: double.infinity,
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 246,
          child: Column(
            children: <Widget>[
              // Drag handle
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  margin: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: BorderColor.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),

              // Main description content
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/bs-confirmation-icon.svg',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(height: 16),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Footer with two buttons
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: AppButton(
                          label: 'Batal',
                          type: AppButtonType.outline,
                          onPress: () {
                            firstButtonOnClick();
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        child: AppButton(
                          label: 'Keluar',
                          type: AppButtonType.filled,
                          onPress: () {
                            secondButtonOnClick();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
