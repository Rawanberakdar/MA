import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions/function.dart';
import '../screen/HomePage.dart';
import '../style/app_colors.dart';
import '../widget/Auth/custom_button.dart';
import '../widget/Auth/custom_formfield.dart';
import '../widget/Auth/custom_header.dart';
import '../widget/Auth/custom_richtext.dart';
import 'signup.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  late UserCredential credential;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool visiable = true;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColors.blue,
            ),
            CustomHeader(
              text: 'تسجيل الدخول',
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.08,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.whiteshade,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.09),
                      child: Image.asset("images/login.png"),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Form(
                      key: formstate,
                      child: Column(
                        children: [
                          CustomFormField(
                            valu: (val) {
                              return validate(val!, 15, 10);
                            },
                            headingText: "البريد الالكتروني",
                            hintText: "البريد الالكتروني",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            controller: _emailController,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomFormField(
                            valu: (val) {
                              return validate(val!, 15, 8);
                            },
                            headingText: "كلمة السر",
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            hintText: "لا تقل عن 8 محارف",
                            obsecureText: visiable,
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    visiable = !visiable;
                                  });
                                }),
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 24),
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "نسيت كلمة السر?",
                              style: TextStyle(
                                  color: AppColors.blue.withOpacity(0.7),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AuthButton(
                      onTap: () async {
                        await signIn();
                      },
                      text: 'تسجيل الدخول',
                    ),
                    CustomRichText(
                      discription: "لا تمتلك حساب؟ سجل معنا  ",
                      text: "إنشاء حساب",
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  signIn() async {
    if (formstate.currentState!.validate()) {
      try {
        credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      if (credential.user!.uid != null) {
        Get.snackbar(
          "welcome",
          "Login completed successfully",
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 23, 2, 107),
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        Get.off(() => HomePage());
      }
    }
  }
}
