// part of 'widgets.dart';

// class AppSearchBar extends StatelessWidget {
//   final Function(String) onSearch;
//   final bool editable;
//   final TextEditingController controller;

//   AppSearchBar({
//     Key? key,
//     required this.onSearch,
//     this.editable = true,
//     required this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//       // var isEdited = Get.find<SearchPageController>().isTextFieldEdited.value;
//       return Container(
//         // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         width: double.infinity,
//         child: Container(
//           padding: const EdgeInsets.only(left: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(24),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 4,
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: AppTextField.search(
//                   textEditingController: controller,
//                   type: AppTextFieldType.search,
//                   state: AppTextFieldState(),
//                   isEditable: editable,
//                   onChanged: (value) {
//                     print(value);
//                     onSearch(value);
//                     // Get.find<SearchPageController>().onChangeListener(value);
//                   },
//                   onClick: () {
//                     print('Search');
//                     editable ? null : Get.toNamed(Routes.SEARCH);
//                   },
//                 ),
//               ),
//               // if (isEdited)
//               //   IconButton(
//               //     icon: Icon(Iconsax.close_circle5,
//               //         size: 20, color: IconColor.secondary),
//               //     onPressed: () {
//               //       // clear text field
//               //       controller.clear();
//               //       Get.find<SearchPageController>().onChangeListener('');
//               //     },
//               //   ),
//             ],
//           ),
//         ),
//       );

//   }
// }

part of 'widgets.dart';

class AppSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final bool editable;
  final TextEditingController controller;
  // final state;

  AppSearchBar({
    Key? key,
    required this.onSearch,
    this.editable = true,
    required this.controller,
    // required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

      // var isEdited = Get.find<SearchPageController>().isTextFieldEdited.value;
      return Row(
            children: [
              Expanded(
                child: AppTextField.search(
                  textEditingController: controller,
                  type: AppTextFieldType.search,
                  state: AppTextFieldState(),
                  isEditable: editable,
                  onChanged: (value) {
                    print(value);
                    onSearch(value);
                    
                  },
                  onClick: () {
                    print('Search');
                    editable ? null : Get.toNamed(Routes.SEARCH);
                  },
                ),
              ),
              // if (isEdited)
              //   IconButton(
              //     icon: Icon(Iconsax.close_circle5,
              //         size: 20, color: IconColor.secondary),
              //     onPressed: () {
              //       // clear text field
              //       controller.clear();
              //       Get.find<SearchPageController>().onChangeListener('');
              //     },
              //   ),
            ],
          );
  }
}
