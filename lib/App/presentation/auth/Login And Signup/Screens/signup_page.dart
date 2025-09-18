import 'package:civic_reporter/App/Core/services/responsive_service.dart';
import 'package:civic_reporter/App/Core/widgets/secondary_button_widget.dart';
import 'package:civic_reporter/App/Core/widgets/snack_bar_constant_widget.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/Screens/login_page.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/widgets/signin_widget.dart';
import 'package:civic_reporter/App/presentation/auth/Login%20And%20Signup/widgets/text_field_widget.dart';
import 'package:civic_reporter/App/presentation/home/screens/home_page.dart';
import 'package:civic_reporter/App/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  final _currentUser = FirebaseAuth.instance.currentUser;

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
      appBar: AppBar(elevation: 0),

      bottomSheet: SecondaryButtonWidget(
        buttonOnPress: () async {
          if (_emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty &&
              _nameController.text.isNotEmpty) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(width: 20),
                    Text("Logging in..."),
                  ],
                ),
              ),
            );

            final result = await repo.register(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
              name: _nameController.text.trim(),
            );

            Navigator.of(context).pop();

            if (result.success) {
              SnackBarConstantWidget.show(
                context,
                "User Registered Successfully",
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            } else {
              SnackBarConstantWidget.show(context, result.message);
            }
          } else {
            SnackBarConstantWidget.show(
              context,
              "Please Fill all the Fields Before Logging In",
            );
          }
        },
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Image.asset('assets/images/choosePass.png'),
            // LottieBuilder.network(
            //   'https://lottie.host/6800f629-4b0a-4256-89c2-70a7aedcbbd1/Wjk5CLxQno.json',
            // ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),

                  Text(
                    'Full Name',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Color(0xff37474F)),
                  ),

                  const SizedBox(height: 10),

                  TextFieldWidget(
                    TextHidden: false,
                    controller: _nameController,
                    hintText: 'Full Name',
                    icon: null,
                  ),

                  const SizedBox(height: 28),

                  Text(
                    'Email Address',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Color(0xff37474F)),
                  ),

                  const SizedBox(height: 10),

                  TextFieldWidget(
                    TextHidden: false,
                    controller: _emailController,
                    hintText: 'Email Address',
                    icon: null,
                  ),
                  const SizedBox(height: 28),

                  Text(
                    'Password ',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Color(0xff37474F)),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    obscureText: !isVisble,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisble = !isVisble;
                          });
                        },
                        child: isVisble == true
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      filled: true,

                      //fillColor: ConstColor.TextfieldBackground,
                      hint: Text('Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        //color: ConstColor.normalBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an Account? ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login_page');
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            // color: ConstColor.AccentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //const SizedBox(height: 50),
                  //sizedbox
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
