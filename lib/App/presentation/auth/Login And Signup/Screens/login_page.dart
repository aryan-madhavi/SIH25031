import 'package:civic_reporter/App/Core/Constants/color_constants.dart';
import 'package:civic_reporter/App/Core/Theme/riverpod/theme_provider.dart';
import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/appbar_widget.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/Core/widgets/snack_bar_constant_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/divider_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/password_text_field.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/signin_widget.dart';
import 'package:civic_reporter/App/presentation/auth/widgets/text_field_widget.dart';
import 'package:civic_reporter/App/presentation/home/screens/home_page.dart';
import 'package:civic_reporter/App/providers/auth_provider.dart';
import 'package:civic_reporter/App/providers/remember_me_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    // preload saved credentials
    final rememberState = ref.read(rememberMeProvider);
    if (rememberState.rememberMe) {
      _emailController.text = rememberState.email;
      _passwordController.text = rememberState.password;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);

    final repo = ref.watch(authRepositoryProvider);
    final rememberState = ref.watch(rememberMeProvider);

    return Scaffold(
      appBar: AppbarWidget('Login', Icons.menu, false, () {}),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ResponsiveService.w(0.05)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: ResponsiveService.fs(0.08),
                ),
              ),

              Text(
                'Login In to your Account.',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveService.fs(0.04),
                  color: ColorConstants.darkGreyColor,
                ),
              ),

              //Image.asset('assets/images/mobilepic.png'),
              Container(
                padding: EdgeInsets.all(ResponsiveService.w(0.01)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveService.h(0.02)),

                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: ResponsiveService.fs(0.05),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: ResponsiveService.h(0.01)),

                    TextFieldWidget(
                      textHidden: false,
                      controller: _emailController,
                      hintText: 'Your Email Address',
                      icon: null,
                    ),

                    SizedBox(height: ResponsiveService.h(0.02)),

                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: ResponsiveService.fs(0.05),
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 10),

                    PasswordTextField(controller: _passwordController),

                    // TextField(
                    //   obscureText: !isVisible,

                    //   controller: _passwordController,

                    //   decoration: InputDecoration(
                    //     suffixIcon: GestureDetector(
                    //       onTap: () {
                    //         setState(() => isVisible = !isVisible);
                    //       },
                    //       child: Icon(
                    //         isVisible ? Icons.visibility : Icons.visibility_off,
                    //       ),
                    //     ),
                    //     filled: true,
                    //     //fillColor: ConstColor.TextfieldBackground,
                    //     hintText: 'Password',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     hintStyle: const TextStyle(fontWeight: FontWeight.w600),
                    //   ),
                    // ),
                    SizedBox(height: ResponsiveService.h(0.01)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: ColorConstants.primaryColorDark,
                              checkColor: ColorConstants.whiteColor,
                              value: rememberState.rememberMe,
                              onChanged: (val) {
                                ref
                                    .read(rememberMeProvider.notifier)
                                    .toggleRememberMe(
                                      val ?? false,
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                              },
                            ),
                            Text(
                              'Remember Me',
                              style: TextStyle(
                                fontSize: ResponsiveService.fs(0.035),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          // onTap: () => Navigator.pushNamed(
                          //   context,
                          //   '/forgot_pass_main_screen',
                          // ),
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              fontSize: ResponsiveService.fs(0.035),
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: ResponsiveService.h(0.05)),

                    SecondaryButtonWidget(
                      buttonLabel: "Login",
                      buttonIcon: null,

                      buttonOnPress: () async {
                        if (_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const AlertDialog(
                              content: Row(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 20),
                                  Text("Logging in..."),
                                ],
                              ),
                            ),
                          );

                          final result = await repo.login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          Navigator.of(context).pop(); // close dialog

                          if (result.success) {
                            SnackBarConstantWidget.show(
                              context,
                              "Login Successful",
                            );

                            // save prefs
                            ref
                                .read(rememberMeProvider.notifier)
                                .toggleRememberMe(
                                  rememberState.rememberMe,
                                  _emailController.text,
                                  _passwordController.text,
                                );

                            Navigator.pushNamed(context, '/home');
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Login Failed'),
                                content: Text(result.message),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Center(child: const Text('OK')),
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

                    DividerWidget(),

                    SizedBox(height: ResponsiveService.h(0.035)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SigninWidget(
                          url: "assets/images/googleicon.png",
                          onPress: () {},
                          // onPress: () async {
                          //   final result = await repo.SignInWithGoogle();
                          //   if (result.FirebaseResult) {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content: Text("Google Sign-In Successful"),
                          //       ),
                          //     );
                          //   }
                          // },
                        ),
                        SizedBox(width: ResponsiveService.w(0.05)),

                        SigninWidget(
                          url: "assets/images/appleicon.png",
                          onPress: () => debugPrint("Apple Login Clicked"),
                        ),
                        const SizedBox(width: 20),
                        SigninWidget(
                          url: "assets/images/facebookicon.png",
                          onPress: () => debugPrint("Facebook Login Clicked"),
                        ),
                      ],
                    ),

                    SizedBox(height: ResponsiveService.h(0.035)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: ResponsiveService.fs(0.035),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/signupPage'),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: ResponsiveService.fs(0.04),
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
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
