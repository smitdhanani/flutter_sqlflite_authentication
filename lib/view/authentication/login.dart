import 'package:flutter/material.dart';
import 'package:sqlflite_authentication/global/services/sqlflite.dart';
import 'package:sqlflite_authentication/global/utils/validator.dart';
import 'package:sqlflite_authentication/model/user_model.dart';
import 'package:sqlflite_authentication/view/home.dart';
import 'package:sqlflite_authentication/view/authentication/register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogin = false;
  final db = SQLHelper();

  login() async {
    var response = await db.login(Users(
        userName: emailController.text, userPassword: passwordController.text));
    if (response == true) {
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeView()));
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(top: 30),
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
                    const SizedBox(height: 10),
                    isLogin == true
                        ? const Text(
                            'Username or Passowrd is Incorrect !',
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 20),
                    SizedBox(
                        height: 50,
                        width: 200,
                        child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                login();
                              }
                            },
                            child: const Text('Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)))),
                    const SizedBox(height: 10),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegsiterView()));
                        },
                        child: const Text('New user Register ?',
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
                hintText: hintext, border: const OutlineInputBorder())));
  }
}
