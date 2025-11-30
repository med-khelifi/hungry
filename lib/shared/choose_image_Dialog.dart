import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageDialog extends StatelessWidget {
  const ChooseImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: CustomText(
        text: "Choose Image",
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: CustomText(
              text: "Take a photo",
              fontSize: 16.sp,
            ),
            onTap: () async {
              final picker = ImagePicker();
              final picked = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context, picked);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title:  CustomText(
              text: "Choose from Gallery",
              fontSize: 16.sp,
            ),
            onTap: () async {
              final picker = ImagePicker();
              final picked = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context, picked);
            },
          ),

        ],
      ),
    );
  }
}
