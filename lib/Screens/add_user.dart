import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:the_validator/the_validator.dart';

import '../constants.dart';
import 'login_Screen.dart';

class AddUser extends StatefulWidget {
  AddUser({super.key, required this.eventName, required this.appbarcolor});
  String eventName;
  Color appbarcolor;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    _submit() {
      final isValid = _formKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();
    }

    void storeData() async {
      final userid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("Users").doc(userid).set(
        {
          "email": emailController.text.trim(),
          "password": passController.text.trim(),
          "name": nameController.text.trim(),
          "role": roleController.text.trim()
        },
      );
    }

    void createUser() async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passController.text.trim(),
            )
            .then(
              (value) => storeData(),
            );
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('User Created'),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
            backgroundColor: widget.appbarcolor,
          ),
        );
        emailController.clear();
        passController.clear();
        nameController.clear();
        roleController.clear();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'weak-password') {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Password is weak "),
                );
              });
        } else if (e.code == 'email-already-in-use') {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("email already in use "),
                );
              });
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: widget.appbarcolor,
          title: Text(
            widget.eventName,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        body: userRole == 'Admin' || userRole == 'Manager'
            ? SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create User',
                            style: TextStyle(
                                color: widget.appbarcolor,
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
                              FieldValidator.required(
                                  message: 'Email is required'),
                              FieldValidator.email(
                                  message: 'Email is not valid'),
                            ]),
                            iconcolor: Colors.black,
                            hintext: 'Email',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textfield(
                            controller: passController,
                            icon: Icons.lock,
                            validator: FieldValidator.multiple([
                              FieldValidator.required(
                                  message: 'Password is required'),
                            ]),
                            iconcolor: Colors.black,
                            hintext: 'Password',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textfield(
                            controller: nameController,
                            icon: Icons.account_circle_sharp,
                            validator: FieldValidator.multiple([
                              FieldValidator.required(
                                  message: 'Customer Name is required'),
                            ]),
                            iconcolor: Colors.black,
                            hintext: 'Name',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          textfield(
                            controller: roleController,
                            icon: Icons.account_circle_sharp,
                            validator: FieldValidator.multiple([
                              FieldValidator.required(
                                  message: 'Role is required'),
                            ]),
                            iconcolor: Colors.black,
                            hintext: 'User Role',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                              text: 'Create User',
                              onTap: () {
                                _submit();
                                createUser();
                              },
                              color: widget.appbarcolor)
                        ],
                      ),
                    )),
              )
            : const Center(
                child: Text('You Dont have Access to this Screen'),
              ));
  }
}
