import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:promethean/screens/auth/login.dart';
import 'package:promethean/utils/unitls.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  TextEditingController _email = TextEditingController();
  var _key = GlobalKey<FormState>();
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          mini: true,
          onPressed: () {
            Navigator.pop(context);
          },
          // focusColor: AppColors.focusColor,
          backgroundColor: AppColors.focusColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backGoundColor,
      body: ListView(
        children: [
          Container(
            height: height,
            width: width,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.5,
                  child: Center(
                      child: Image.asset(
                    'assets/images/finlalogo.png',
                    height: height * 0.3,
                    fit: BoxFit.contain,
                  )),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: height * 0.4,
                      width: width,
                      decoration: BoxDecoration(
                        color: AppColors.focusColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: Text(
                              "Forgot Password?",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.backGoundColor,
                                fontSize: width * 0.06,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            width: width * 0.75,
                            child: Text(
                              "Don't worry! It occurs. Please enter the email address linked with your account.",
                              style: TextStyle(
                                color: Color(0xff8390a1),
                                fontSize: width * 0.035,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Form(
                            key: _key,
                            child: Container(
                              width: width * 0.75,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xffdadada),
                                  width: 1,
                                ),
                                color: Color(0xfff7f8f9),
                              ),
                              child: TextFormField(
                                controller: _email,
                                style: TextStyle(
                                  color: AppColors.backGoundColor,
                                  fontSize: width * 0.04,
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: width * 0.035,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w700,
                                    ),
                                    hintText: "Enter your registered email id",
                                    hintStyle: TextStyle(
                                      color: Color(0xff8390a1),
                                      fontSize: width * 0.035,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Container(
                            width: width * 0.75,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff1e232c),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: MaterialButton(
                                onPressed: (() {
                                  if (_key.currentState!.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (contex) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                                color:
                                                    AppColors.backGoundColor),
                                          );
                                        });
                                    FirebaseAuth.instance
                                        .sendPasswordResetEmail(
                                            email: _email.text)
                                        .then((value) {
                                      const snackBar = SnackBar(
                                        content: Text(
                                            'Check you mail to reset your password'),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.pop(context);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          (route) => false);
                                    });
                                  }
                                }),
                                child: Center(
                                  child: Text(
                                    "Send Code",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
