part of '../../widgets.dart';

class BsImagePicker extends GetView<BsImagePickerController> {
  const BsImagePicker({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(BsImagePickerController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Drag handle
              const BsNotch(),
              const SizedBox(height: 8),
              Text(
                'image_picker_gallery'.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: TextColor.secondary),
              ),
              const SizedBox(height: 8),
              ListTile(
                onTap: () {
                  controller.onClickCamera();
                },
                leading: Icon(Icons.photo_camera, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  'image_picker_camera'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: TextColor.secondary),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              AppDivider(verticalSpace: 0),
              ListTile(
                onTap: () {
                  controller.onClickGallery();
                
                },
                leading: Icon(Icons.photo_library, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                title: Text(
                  'Pilih dari Galeri',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: TextColor.secondary),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'confirm'.tr,
                onPress: () {
                  Get.back();
                },
                type: AppButtonType.filled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
