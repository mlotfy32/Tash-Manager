import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/features/profile/presentation/cubit/log_out.dart';
import 'package:task/main.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ).withPadding(top: 20.h, bottom: 30.h).center,
              Text(
                Supabase
                        .instance
                        .client
                        .auth
                        .currentUser
                        ?.userMetadata?['username'] ??
                    '',
                style: AppFonts.f16Redular717786().copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                Supabase.instance.client.auth.currentUser?.email ?? '',
                style: AppFonts.f16Redular717786().copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dark Mode',
                    style: AppFonts.f20ExtraBold0F172A().copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Switch(
                    value: mode,
                    onChanged: (value) => changeThemeCubit.changeTheme(),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => logOut(context: context),
                child: Text(
                  'Log Out',
                  style: AppFonts.f20ExtraBold0F172A().copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ).withPadding(horizontal: 12.w),
        ),
      ),
    );
  }
}
