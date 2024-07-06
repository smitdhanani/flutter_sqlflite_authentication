import 'package:flutter/material.dart';
import 'package:sqlflite_authentication/global/services/sqlflite.dart';
import 'package:sqlflite_authentication/global/utils/validator.dart';
import 'package:sqlflite_authentication/model/user_model.dart';
import 'package:sqlflite_authentication/view/authentication/login.dart';

class RegsiterView extends StatefulWidget {
  const RegsiterView({super.key});

  @override
  State<RegsiterView> createState() => _LoginViewState();
}

class _LoginViewState extends State<RegsiterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassowrd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Image.asset('assets/images/login.jpg', height: 400),
                    buildTextField(
                        hintext: 'Enter Email',
                        controlller: emailController,
                        validator: Validator.validateEmail),
                    buildTextField(
                        hintext: 'Enter Password',
                        controlller: passwordController,
                        validator: Validator.validatePassword),
                    buildTextField(
                        hintext: 'Confirm Password',
                        controlller: confirmPassowrd,
                        validator: confirmPassword),
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 50,
                        width: 200,
                        child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              isValid();
                            },
                            child: const Text('Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)))),
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: const Text('Already a user Login ?',
                            style: TextStyle(fontSize: 15)))
                  ]),
                ))));
  }

  buildTextField(
      {required String hintext,
      required TextEditingController controlller,
      required FormFieldValidator<String?>? validator}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          controller: controlller,
          validator: validator,
          decoration: InputDecoration(
              hintText: hintext, border: const OutlineInputBorder())),
    );
  }

  String? confirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please Enter Your Passowrd';
    } else if (value != passwordController.text) {
      return 'Password Does not match';
    }
    return null;
  }

  isValid() {
    if (_formKey.currentState!.validate()) {
      final db = SQLHelper();

      db
          .register(Users(
              userName: emailController.text,
              userPassword: passwordController.text))
          .whenComplete(() => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginView())));
    }
  }
}
