import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/Core/widgets/snack_bar_constant_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/password_text_field.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/signin_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/text_field_widget.dart';
import 'package:civic_reporter/App/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  bool isVisble = false;

  // final _currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(authRepositoryProvider);

    return Scaffold(
      appBar: AppbarWidget('SignUp', Icons.menu, false, () {}),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Join Us...',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: ResponsiveService.fs(0.08),
                ),
              ),

              Text(
                'Create an account.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveService.fs(0.04),
                  color: ColorConstants.darkGreyColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(ResponsiveService.w(0.015)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveService.h(0.02)),

                    Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: ResponsiveService.fs(0.05),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: ResponsiveService.h(0.01)),

                    TextFieldWidget(
                      textHidden: false,
                      controller: _nameController,
                      hintText: 'Your Name',
                      icon: null,
                    ),

                    SizedBox(height: ResponsiveService.h(0.02)),

                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: ResponsiveService.fs(0.05),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFieldWidget(
                      textHidden: false,
                      controller: _emailController,
                      hintText: 'example@gmail.com',
                      icon: null,
                    ),
                    SizedBox(height: ResponsiveService.h(0.02)),

                    Text(
                      'Password ',
                      style: TextStyle(
                        fontSize: ResponsiveService.fs(0.05),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    PasswordTextField(controller: _passwordController),
                    SizedBox(height: ResponsiveService.h(0.05)),

                    SecondaryButtonWidget(
                      buttonLabel: "SignUp",
                      buttonIcon: null,
                      buttonOnPress: () async {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _nameController.text.isNotEmpty) {
                          //*dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text("Creating Account..."),
                                ],
                              ),
                            ),
                          );

                          final result = await repo.register(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim(),
                          );

                          Navigator.of(context).pop(); //* pop the dialog

                          if (result.success) {
                            SnackBarConstantWidget.show(
                              context,
                              "User Registered Successfully",
                            );

                            Navigator.pushNamed(context, '/loginPage');
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Registration Failed'),
                                content: Text(result.message),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else {
                          SnackBarConstantWidget.show(
                            context,
                            "Please Fill all the Fields Before Logging In",
                          );
                        }
                      },
                    ),

                    SizedBox(height: ResponsiveService.h(0.1)),

                    //* divider
                    //divider
                    Row(
                      children: <Widget>[
                        Expanded(child: Divider(color: Color(0xff878787))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Sign in With",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff878787),
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xff878787))),
                      ],
                    ),

                    //sizedbox
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        SigninWidget(
                          onPress: () {},
                          url: "assets/images/googleicon.png",
                          // onPress: () async {
                          //   try {
                          //     final result = await repo.SignInWithGoogle();
                          //     if (result.FirebaseResult) {
                          //       Get.snackbar(
                          //         'Authnetication Successful',
                          //         'Google sign in was successful',
                          //       );
                          //     } else {
                          //       Get.snackbar('Authnetication Failed', '');
                          //     }
                          //   } catch (e) {
                          //     Get.snackbar(
                          //       'Error',
                          //       'Failed to sign in with Google',
                          //     );
                          //   }
                          // },
                        ),
                        SizedBox(width: 20),
                        SigninWidget(
                          url: "assets/images/appleicon.png",
                          onPress: () {
                            print('called apple');
                          },
                        ),
                        SizedBox(width: 20),
                        SigninWidget(
                          url: "assets/images/facebookicon.png",
                          onPress: () {
                            print('called facebook');
                          },
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 32),
                    //*register for user
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: ResponsiveService.fs(0.035),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/loginPage'),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: ResponsiveService.fs(0.04),
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 50),
                    //sizedbox
                    SizedBox(height: ResponsiveService.h(0.1)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
