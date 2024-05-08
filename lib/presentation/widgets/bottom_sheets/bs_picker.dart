import 'package:flutter/material.dart';
import 'package:hino_driver_app/infrastructure/theme/app_color.dart';
import 'package:hino_driver_app/presentation/widgets/app_radio_button.dart';

class CustomPicker extends StatefulWidget {
  final List<String> options;

  CustomPicker({Key? key, required this.options}) : super(key: key);

  @override
  _CustomPickerState createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.only(top: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Drag handle
              Center(
                child: Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: BorderColor.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Title',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: TextColor.secondary),
                ),
              ),
              SizedBox(height: 16),
              ...widget.options.map((String value) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      title: Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: TextColor.secondary),
                      ),
                      trailing: CustomRadioButton(
                        isSelected: selectedOption == value,
                        onSelect: () {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(color: BorderColor.disabled),
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text('Simpan Perubahan',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: PrimaryColor.main,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Color(0xFFCB3A31), width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
