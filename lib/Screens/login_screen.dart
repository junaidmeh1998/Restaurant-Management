import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/Screens/home_screen.dart';
import 'package:hotelmanagement/constants.dart';
import 'package:the_validator/the_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
  }

  void showMessage(context, message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  void signuserin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logged In'),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          backgroundColor: Colors.blueAccent,
        ),
      );
      emailController.clear();
      passController.clear();
    } on FirebaseAuthException catch (e) {
      //if wwe have an eror pop the corcle and show us message
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        //wrong email
        showMessage(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        showMessage(context, 'wrong-password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login Screen',
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                textfield(
                  controller: emailController,
                  icon: Icons.email,
                  validator: FieldValidator.multiple([
                    FieldValidator.required(message: 'Email is required'),
                    FieldValidator.email(message: 'Email is not valid'),
                  ]),
                  iconcolor: Colors.black,
                  hintext: 'Your Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                textfield(
                  controller: passController,
                  icon: Icons.lock,
                  validator: FieldValidator.multiple([
                    FieldValidator.required(message: 'Password is required'),
                  ]),
                  iconcolor: Colors.black,
                  hintext: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    await _submit();
                    signuserin();
                  },
                  color: Colors.lightBlue,
                )
              ],
            ),
          )),
    );
  }
}

class textfield extends StatelessWidget {
  textfield(
      {super.key,
      required this.controller,
      required this.icon,
      required this.validator,
      required this.iconcolor,
      required this.hintext});
  TextEditingController controller;
  IconData icon;
  String? Function(String?)? validator;
  Color? iconcolor;
  String? hintext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintText: hintext,
          prefixIcon: Icon(
            icon,
            color: iconcolor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.3,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 1.3,
            ),
          ),
        ),
        validator: validator);
  }
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color});
  String text;
  void Function()? onTap;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
