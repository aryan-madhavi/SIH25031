import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/bottom_nav_bar_widget.dart';
import 'package:civic_reporter/App/presentation/UserProfile/widgets/logout_button_widget.dart';
import 'package:civic_reporter/App/presentation/UserProfile/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  User? usr = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget('Profile', Icons.menu, true, () {}),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.037)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //*profile
              ProfileWidget(
                Phone_number: usr!.phoneNumber,
                user_name: usr!.displayName,
              ),
              SizedBox(height: ResponsiveService.h(0.021)),
              //* ListView blocks
              //  HorizontalTabarWidget(),
              SizedBox(height: ResponsiveService.h(0.021)),

              //giftCard
              // CashGiftCardWidget(),
              SizedBox(height: ResponsiveService.h(0.01)),

              //information Panel:
              Text(
                'Your Information',
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.034),
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.darkInputFillColor,
                ),
              ),
              SizedBox(height: ResponsiveService.h(0.005)),

              //InformationListWidget(),
              SizedBox(height: ResponsiveService.h(0.01)),

              //Secondary information Panel:
              Text(
                'Other Information',
                style: TextStyle(
                  fontSize: ResponsiveService.fs(0.034),
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.greenColor,
                ),
              ),
              SizedBox(height: ResponsiveService.h(0.005)),

              //InformationListWidgetSecondary(),
              SizedBox(height: ResponsiveService.h(0.021)),

              //*logout Button:
              LogoutButtonWidget(),

              SizedBox(height: ResponsiveService.h(0.021)),
            ],
          ),
        ),
      ),
    );
  }
}
