import 'package:e_menu_app/widgets/change_screen.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/shared/theme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  bool _isHiddenPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
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
                borderRadius: BorderRadius.circular(10),
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
                context, '/main-page', (route) => false);
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
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  image: 'assets/icon/icon_profile_select.png',
                  controller: fullnameController,
                  hintText: "Full Name",
                ),
                CustomTextField(
                  image: 'assets/icon/icon_phone.png',
                  controller: usernameController,
                  hintText: "No HP",
                ),
                CustomTextField(
                  image: 'assets/icon/icon_email.png',
                  controller: emailController,
                  hintText: 'Email',
                ),
                passwordInput(),
                signUpButton(),
                // isLoading ? LoadingButton() : signInButton(),
                const Spacer(),
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
          context.read<AuthCubit>().signUp(
              fullname: fullnameController.text,
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text);
        },
        style: TextButton.styleFrom(
            backgroundColor: priceColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
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
            backgroundColor: priceColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: const CircularProgressIndicator());
  }
}
