import 'package:e_menu_app/widgets/change_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/shared/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = RegExp(p);

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController noHPController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  bool _isHiddenPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void vaildation() async {
    if (displayNameController.text.isEmpty &&
        noHPController.text.isEmpty &&
        emailController.text.isEmpty &&
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All Field Are Empty"),
        ),
      );
    } else if (displayNameController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email Is Empty"),
        ),
      );
    } else if (!regExp.hasMatch(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please Try Vaild Email"),
        ),
      );
    } else if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password Is Empty"),
        ),
      );
    } else if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password  Is Too Short"),
        ),
      );
    } else if (noHPController.text.length < 12 ||
        noHPController.text.length > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Phone Number Must Be 12"),
        ),
      );
    } else {
      context.read<AuthCubit>().signUp(
          displayName: displayNameController.text,
          username: noHPController.text,
          email: emailController.text,
          password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              decoration: BoxDecoration(
                color: const Color(0xffEFF0F6),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/icon_password.png",
                      width: 17,
                      color: secondsubtitleColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: passwordController,
                        style: primaryTextStyle,
                        obscureText: _isHiddenPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _isHiddenPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHiddenPassword
                                  ? secondsubtitleColor
                                  : Colors.grey,
                            ),
                          ),
                          border: InputBorder.none,
                          // isCollapsed: true,
                          hintText: "Password",
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget signUpButton() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Sign Up Success"),
              duration: const Duration(seconds: 2),
              backgroundColor: priceColor,
            ));
            Navigator.pushNamedAndRemoveUntil(
                context, '/home-page', (route) => false);
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 40),
            height: 50,
            width: double.infinity,
            child: (state is AuthLoading)
                ? _loginLoadingButton()
                : _loginButton(context),
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: secondsubtitleColor,
            ),
          ),
          automaticallyImplyLeading: true,
          titleSpacing: -5,
          elevation: 0,
          title: Text(
            "Sign Up",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CustomTextField(
                //   image: 'assets/icon/icon_profile_select.png',
                //   controller: displayNameController,
                //   hintText: "Full Name",
                // ),
                // CustomTextField(
                //   image: 'assets/icon/phone.png',
                //   controller: noHPController,
                //   hintText: "Phone Numer",
                // ),
                // CustomTextField(
                //   image: 'assets/icon/icon_email.png',
                //   controller: emailController,
                //   hintText: 'Email',
                // ),
                passwordInput(),
                signUpButton(),
                // isLoading ? LoadingButton() : signInButton(),
                const SizedBox(
                  height: 20,
                ),
                ChangeScreen(
                  teks: "Already have an account?",
                  onTapp: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                  screenTeks: " Sign In",
                ),
              ],
            ),
          ),
        ));
  }

  TextButton _loginButton(BuildContext context) {
    return TextButton(
        // onPressed: hendleSignIn,
        onPressed: () {
          vaildation();
        },
        style: TextButton.styleFrom(
            backgroundColor: priceColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(
          "Submit",
          style:
              secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ));
  }

  TextButton _loginLoadingButton() {
    return TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: const CircularProgressIndicator());
  }
}
