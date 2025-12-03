import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/constants/app_routes.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/views/guest_view.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/auth/widgets/custom_user_text_field.dart';
import 'package:hungry/shared/choose_image_Dialog.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AuthRepo _authRepo;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController vizaController;
  UserModel? user;
  String? imagePath;

  bool isLoading = false;
  bool isUpdating = false;
  bool isLoggingOut = false;
  bool isGuest = false;
  Future<void> loadUser() async {
    setState(() => isLoading = true);
    final userResponse = await _authRepo.getCurrentUserInfo();
    setState(() => isLoading = false);
    if (userResponse.isFailure) {
      if (context.mounted) {
        CustomErrorSnackBar.show(
          context,
          userResponse.error?.message ?? "Login failed",
        );
      }
    } else {
      setState(() {
        user = userResponse.data;
        _setUserInfo();
      });
    }
  }

  Future<void> updateProfile() async {
    setState(() => isUpdating = true);
    final userResponse = await _authRepo.updateUserInfo(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      viza: vizaController.text.trim(),
      imagePath: imagePath ?? user?.image,
    );
    setState(() => isUpdating = false);
    if (userResponse.isFailure) {
      if (context.mounted) {
        CustomErrorSnackBar.show(
          context,
          userResponse.error?.message ?? "Update failed",
        );
      }
    } else {
      if (context.mounted) {
        CustomErrorSnackBar.show(
          context,
          "Profile updated successfully",
          isError: false,
        );
        loadUser();
      }
    }
  }

  Future<void> logout() async {
    setState(() => isLoggingOut = true);
    var res = await _authRepo.logout();
    setState(() => isLoggingOut = false);

    if (res.isFailure) {
      if (context.mounted) {
        CustomErrorSnackBar.show(context, res.error?.message ?? "Login failed");
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo();
    if (_authRepo.isGuest) {
      return;
    }
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    vizaController = TextEditingController();

    if (_authRepo.currentUser != null) {
      setState(() {
        user = _authRepo.currentUser;
        _setUserInfo();
      });
    } else {
      loadUser();
    }
  }

  void _setUserInfo() {
    nameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
    addressController.text = user?.address ?? "";
    vizaController.text = user?.viza ?? "";
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  ImageProvider? _getProfileImage() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return FileImage(File(imagePath!));
    }

    if (user?.image != null && user!.image!.isNotEmpty) {
      return NetworkImage(user!.image!);
    }
    // No image → return placeholder
    return const AssetImage(AppAssets.placeholder);
  }

  @override
  Widget build(BuildContext context) {
    return _authRepo.isGuest
        ? GuestView()
        : Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SafeArea(
              child: RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: loadUser,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(10.h),

                          /// --- Profile Picture ---
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 55.r,
                                  backgroundColor: Colors.white.withOpacity(
                                    0.3,
                                  ),
                                  backgroundImage: _getProfileImage(),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final file = await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const ChooseImageDialog(),
                                    );
                                    if (file != null) {
                                      setState(() => imagePath = file.path);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 18.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Gap(30.h),

                          CustomUserTextField(
                            controller: nameController,
                            labelText: "name",
                          ),

                          Gap(15.h),

                          CustomUserTextField(
                            controller: emailController,
                            labelText: "Email Address",
                          ),
                          Gap(15.h),
                          CustomUserTextField(
                            controller: addressController,
                            labelText: "Address",
                          ),

                          Gap(10.h),

                          /// Divider
                          Divider(
                            color: Colors.white.withOpacity(0.4),
                            thickness: 1,
                          ),
                          Gap(10.h),
                          user?.viza?.isEmpty != null
                              ? _paymentTile(
                                  value: "visa",
                                  title: "Debit Card",
                                  subtitle: user?.viza ?? "",
                                  icon: Image.asset(
                                    AppAssets.viza,
                                    width: 55.w,
                                  ),
                                )
                              : CustomUserTextField(
                                  controller: vizaController,
                                  labelText: "Visa",
                                ),

                          Gap(30.h),
                          Row(
                            children: [
                              /// Save Button
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      updateProfile();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.whiteColor,
                                      foregroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                    child: isUpdating
                                        ? CupertinoActivityIndicator()
                                        : CustomText(
                                            text: "Save Changes",
                                            color: AppColors.primaryColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  ),
                                ),
                              ),

                              Gap(15.w),
                              Expanded(
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: logout,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                    ),
                                    child: isLoggingOut
                                        ? CupertinoActivityIndicator()
                                        : CustomText(
                                            text: "Logout",
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(80.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  Widget _paymentTile({
    required String value,
    required String title,
    String? subtitle,
    required Widget icon,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(15.r),
      elevation: 3,
      child: RadioListTile<String>(
        value: value,
        groupValue: "visa",
        activeColor: AppColors.secondColor,
        onChanged: (value) {
          // setState(() => selectedPayment = value!);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
        title: Row(
          children: [
            icon,
            Gap(15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: AppColors.secondColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                if (subtitle != null)
                  CustomText(
                    text: subtitle,
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
