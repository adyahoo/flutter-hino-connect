import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hino_driver_app/data/data_sources/data_source.dart';
import 'package:hino_driver_app/domain/core/entities/user_model.dart';
import 'package:hino_driver_app/domain/core/interfaces/i_use_case.dart';
import 'package:hino_driver_app/infrastructure/client/exceptions/ApiException.dart';
import 'package:hino_driver_app/infrastructure/navigation/routes.dart';
import 'package:hino_driver_app/infrastructure/utils.dart';

class FaceRecognitionUseCase implements IFaceRecognitionUseCase {
  const FaceRecognitionUseCase({required this.dataSource});

  final UserDataSource dataSource;

  @override
  Future<UserModel> verifyDriverFace(File image) async {
    try {
      final response = await dataSource.verifyDriverFace(image);
      final data = UserModel(
        id: response.id,
        name: response.name,
        email: response.email,
        profilePic: response.profilePic,
        phoneCode: response.phoneCode,
        phone: response.phone,
      );

      // Show the success dialog
      await Get.dialog(
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xff333333),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/images/face_recog_success.gif'),
                  height: 140,
                  width: 140,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "ID wajah sukses dikenali",
                    style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Close the dialog after 3 seconds and navigate to the Scan QR page
      // await Future.delayed(Duration(seconds: 3), () {
        if (Get.isDialogOpen ?? false) {
          Get.back(); // Close the dialog
          
          Get.toNamed(Routes.SCAN_QR);
        }
      // });

      return data;
    } on ApiException catch (e) {
      Get.back(); // Close the dialog
      errorHandler(e);
      rethrow;
    }
  }
}
