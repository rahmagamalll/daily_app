import 'dart:io';
import 'package:daily_app/core/helper/share_pref_helper.dart';
import 'package:daily_app/core/helper/shared_pref_keys.dart';
import 'package:daily_app/core/theming/colors.dart';
import 'package:daily_app/core/widgets/custom_snack_bar.dart';
import 'package:daily_app/features/home/logic/cubit/manage_top_app_bar_cubit.dart';
import 'package:daily_app/features/profile/ui/widgets/change_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class UserImage extends StatefulWidget {
  UserImage({Key? key, required this.onChangedPhoto}) : super(key: key);
  void Function(String) onChangedPhoto;
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  String? imagePathFromGallery;

  @override
  void initState() {
    super.initState();

    _fetchPhoto();
  }

  Future<void> _fetchPhoto() async {
    String? storedImagePath = await SharePrefHelper.getString(
      SharedPrefKeys.userPhoto,
    );
    if (storedImagePath != null && storedImagePath.isNotEmpty) {
      setState(() {
        imagePathFromGallery = storedImagePath;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        imagePathFromGallery = pickedFile.path;
      });

      await SharePrefHelper.setData(
        SharedPrefKeys.userPhoto,
        imagePathFromGallery,
      );

      CustomSnackBar.show(context, 'photo updated successfully');
    }
  }

  Widget buildImage() {
    if (imagePathFromGallery != null &&
        File(imagePathFromGallery!).existsSync()) {
      widget.onChangedPhoto(imagePathFromGallery!);
      context
          .read<ManageTopAppBarCubit>()
          .updateTopAppBarimage(imagePathFromGallery!);

      return Image.file(
        File(imagePathFromGallery!),
        width: 170.r,
        height: 170.r,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      'assets/images/user_image.png',
      width: 170.r,
      height: 170.r,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6.r,
                spreadRadius: 1.r,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8.r,
                spreadRadius: -2.r,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 65.r,
            backgroundColor: ColorsManager.primaryColor.withOpacity(0.4),
            child: CircleAvatar(
              radius: 59.r,
              backgroundColor: ColorsManager.white,
              child: ClipOval(child: buildImage()),
            ),
          ),
        ),
        Positioned(
          right: 90.w,
          top: 84.h,
          child: ChangeImagePlus(choosFromGalleyOnTap: _pickImageFromGallery),
        ),
      ],
    );
  }
}
