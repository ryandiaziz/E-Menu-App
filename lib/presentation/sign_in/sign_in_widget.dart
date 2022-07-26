import 'package:e_menu_app/providers/google_sign_in.dart';
import 'package:e_menu_app/widgets/change_screen.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_menu_app/aplication/auth/cubit/auth_cubit.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // bool isLoading = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isHiddenPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void vaildation() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Both Flied Are Empty"),
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
    } else {
      context.read<AuthCubit>().signIn(
          email: emailController.text, password: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
          // margin: const EdgeInsets.only(
          //   top: 30,
          // ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/icon/icon_emenu.png',
            width: 200,
          ),
          const SizedBox(
            height: 2,
          ),
        ],
      ));
    }

    Widget googleSignIn() {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity, 50)),
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.amber,
        ),
        label: Text("Login With Google"),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 12),
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
                      'assets/icon/icon_password.png',
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

    Widget signInButton() {
      return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home-page', (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Login Berhasil'),
            backgroundColor: priceColor,
          ));
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ));
        }
      }, builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          height: 50,
          width: double.infinity,
          child: (state is AuthLoading)
              ? _loadingButtonLogin()
              : _buttonLogin(context),
        );
      });
    }

    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          // centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
          ),
          automaticallyImplyLeading: true,
          titleSpacing: -5,
          elevation: 0,
          title: Text(
            "Login",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
            // fontWeight: semiBold,
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(0),
                  height: MediaQuery.of(context).size.height - 130,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: header()),
                      googleSignIn(),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          "atau",
                          style: secondSubtitleTextStyle,
                        ),
                      ),
                      // CustomTextField(
                      //     image: 'assets/icon/icon_email.png',
                      //     controller: emailController,
                      //     hintText: 'Email'),
                      passwordInput(),
                      // isLoading ? LoadingButton() : signInButton(),
                      signInButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      ChangeScreen(
                        teks: "Don't have an account?",
                        onTapp: () {
                          Navigator.pushNamed(context, '/sign-up');
                        },
                        screenTeks: " Sign Up",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  TextButton _buttonLogin(BuildContext context) {
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
          "Login",
          style:
              secondaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ));
  }

  TextButton _loadingButtonLogin() {
    return TextButton(
        onPressed: null,
        // onPressed: hendleSignIn,
        style: TextButton.styleFrom(
          backgroundColor: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const CircularProgressIndicator());
  }
}
