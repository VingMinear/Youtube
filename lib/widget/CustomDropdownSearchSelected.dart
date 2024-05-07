// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:multi_vendor/controllers/product/CreateProductController.dart';
// import 'package:multi_vendor/models/CategoryModel/CategoryModel.dart';
// import 'package:multi_vendor/widget/CustomTextField.dart';

// import '../controllers/product/ProdcutController.dart';

// class CustomDropdownSearchSelected extends StatelessWidget {
//   final ScrollController? scrollController;
//   final Function(String key)? onSearch;
//   const CustomDropdownSearchSelected(
//       {super.key, this.onSearch, this.scrollController});

//   get statesController => null;
//   @override
//   Widget build(BuildContext context) {
//     final key = GlobalKey();
//     return GetX<>(builder: (controller) {
//       return MenuAnchor(
//         key: key,
//         childFocusNode: FocusNode(
//           canRequestFocus: true,
//           skipTraversal: true,
//         ),
//         style: MenuStyle(
//           backgroundColor: MaterialStateProperty.all(
//             AppColor.colorScheme.primaryContainer,
//           ),
//           shadowColor: MaterialStateProperty.all(
//             AppColor.colorScheme.primaryContainer,
//           ),
//           padding: MaterialStateProperty.all(
//             const EdgeInsets.symmetric(
//               horizontal: 0,
//             ),
//           ),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           ),
//           maximumSize: MaterialStateProperty.all(Size.fromHeight(250.h)),
//         ),
//         menuChildren: [
//           Container(
//             height: 250.h,
//             width: appWidth() / 1.5,
//             color: Colors.white,
//             child: Column(
//               children: [
//                 CustomTextField(
//                   autoFocus: false,
//                   borderRadius: 10,
//                   backGroundColor: AppColor.txtFieldColor,
//                   textInputAction: TextInputAction.search,
//                   hint: 'search'.tr,
//                   subFixIcon: Icon(
//                     Icons.search,
//                     size: 25,
//                     color: AppColor.colorScheme.onPrimaryContainer,
//                   ),
//                   onChange: (text) {
//                     if (onSearch != null) {
//                       onSearch!(text);
//                     }
//                     {
//                       logWarning('OnSearch Call in null');
//                     }
//                   },
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                       keyboardDismissBehavior:
//                           ScrollViewKeyboardDismissBehavior.onDrag,
//                       child: Column(
//                         children: List.generate(
//                           controller.a.length,
//                           (index) => _buildMenuItem(
//                             context: context,
//                             cat: controller.allBrandAndCategory[index],
//                             onPress: () {
//                               controller.updateListSelected(
//                                 category: controller.allBrandAndCategory[index],
//                               );
//                             },
//                           ),
//                         ),
//                       )),
//                 )
//               ],
//             ),
//           )
//         ],
//         builder:
//             (BuildContext context, MenuController controller, Widget? child) {
//           return GestureDetector(
//             onTap: () {
//               if (controller.isOpen) {
//                 controller.close();
//               } else {
//                 controller.open();
//               }
//             },
//             child: Container(
//               padding: const EdgeInsets.all(13),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.grey[200],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GetX<CreateProductController>(
//                     builder: (controller) => Expanded(
//                       child: controller.listSelectedCate.isEmpty
//                           ? Text(
//                               'select_category'.tr,
//                               style: AppText.txt15,
//                             )
//                           : Wrap(
//                               spacing: 10,
//                               runSpacing: 10,
//                               children: List.generate(
//                                 controller.listSelectedCate.length,
//                                 (index) => buildSeletedItem(
//                                   title:
//                                       controller.listSelectedCate[index].name,
//                                   context: context,
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ),
//                   const Icon(
//                     Icons.keyboard_arrow_down_rounded,
//                     size: 25,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _buildMenuItem(
//       {required BuildContext context,
//       required CategoryModel cat,
//       var onPress}) {
//     return Material(
//         elevation: .6,
//         //width: double.infinity,
//         shadowColor: Colors.grey[200],
//         child: GetX<ProductController>(
//           builder: (contt) => InkWell(
//               onTap: () {
//                 onPress();
//                 logWarning('clicked');
//               },
//               splashColor: Colors.grey[200],
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Text(cat.name),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Icon(
//                         cat.isSelected.value
//                             ? Icons.check_box_outlined
//                             : Icons.check_box_outline_blank,
//                         color: cat.isSelected.value
//                             ? AppColor.primaryColor
//                             : Colors.black,
//                         size: 25,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ));
//   }

//   Widget buildSeletedItem(
//       {required String title, required BuildContext context}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: AppColor.colorScheme.onSecondaryContainer,
//       ),
//       child: Text(
//         title,
//         style: AppText.txt14,
//       ),
//     );
//   }
// }
