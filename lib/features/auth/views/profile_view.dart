import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_assets.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/auth/widgets/custom_snack_bar.dart';
import 'package:hungry/features/auth/widgets/custom_user_text_field.dart';
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

  bool isLoading = false;
  Future<void> loadUser() async {
    setState(() => isLoading = true);
    final userResponse = await _authRepo.getCurrentUserInfo();
    setState(() => isLoading = false);
    if (userResponse.isFailure) {
      if (context.mounted) {
        CustomErrorSnackBar.show(context, userResponse.error?.message ?? "Login failed");
      }
    } else {
        user = userResponse.data;
    }
  }
  @override
  void initState() {
    super.initState();
    _authRepo = AuthRepo();
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    vizaController = TextEditingController();
    loadUser().then((value){

      nameController.text = user?.name ?? "";
      emailController.text = user?.email ?? "";
      addressController.text = user?.address ?? "";
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: loadUser,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Skeletonizer(
              enabled: isLoading,
              child: Column(
                children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
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
                                backgroundColor: Colors.white.withOpacity(0.3),
                                backgroundImage: user?.image != null ? NetworkImage(user!.image!) : null ,
                              ),
                              Container(
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
                        Divider(color: Colors.white.withOpacity(0.4), thickness: 1),
                        Gap( 10.h),
                       user?.viza == null ? _paymentTile(
                          value: "viza",
                          title: "Debit Card",
                          subtitle: "3566 **** **** 0505",
                          icon: Image.asset(AppAssets.viza, width: 55.w),
                        ) : CustomUserTextField(
                         controller: vizaController,
                         labelText: "Viza",
                       ),
                      ],
                    ),
                  ),
  Gap(10.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                    child: Row(
                      children: [
                        /// Save Button
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.whiteColor,
                                foregroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
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
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(80.h),
                ],
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
        groupValue: "viza",
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
