import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/Screens/login_page.dart';
import 'package:civic_reporter/App/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoutButtonWidget extends ConsumerStatefulWidget {
  const LogoutButtonWidget({super.key});

  @override
  ConsumerState<LogoutButtonWidget> createState() => _LogoutButtonWidgetState();
}

class _LogoutButtonWidgetState extends ConsumerState<LogoutButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(authRepositoryProvider);

    return GestureDetector(
      onTap: () async {
        setState(() {
          _isPressed = true;
        });
        print('Logout button clicked');

        try {
          await repo.signOut();

          if (!mounted) return;

          setState(() {
            _isPressed = false;
          });

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        } catch (e) {
          if (mounted) {
            setState(() {
              _isPressed = false;
            });
          }
          print("Logout failed: $e");
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: ResponsiveService.h(0.01)),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.red : ColorConstants.darkGreyColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorConstants.greenColor,
            width: ResponsiveService.w(0.004),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          "Logout",
          style: TextStyle(
            fontSize: ResponsiveService.fs(0.037),
            fontWeight: FontWeight.w600,
            color: _isPressed
                ? ColorConstants.whiteColor
                : ColorConstants.blackColor,
          ),
        ),
      ),
    );
  }
}
