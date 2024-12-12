import 'dart:ffi';

import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/common/widgets/buttons/basic_app_button.dart';
import 'package:copyify/core/configs/assets/app_vectors.dart';
import 'package:copyify/data/models/auth/create_user_req.dart';
import 'package:copyify/domain/usecases/auth/register.dart';
import 'package:copyify/presentation/auth/pages/login_page.dart';
import 'package:copyify/presentation/home/pages/home.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              _registerText(),
              const SizedBox(height: 50,),
              _fullNameField(context),
              const SizedBox(height: 30,),
              _emailField(context),
              const SizedBox(height: 30,),
              _passField(context),
              const SizedBox(height: 30,),
              BasicAppButton(
                  onPressed: () async{
                    var result = await sl<RegisterUseCase>().call(
                      params: CreateUserReq(
                          fullName: _fullName.text.toString(),
                          email: _email.text.toString(),
                          password: _password.text.toString()
                      )
                    );

                    return result.fold(
                            (l) {
                              var snackBar = SnackBar(content: Text(l), behavior: SnackBarBehavior.floating,);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            (r) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                  (route) => false);
                            }
                    );
                  },
                  title: "Create Account"
              )
          ],
        ),
      ),
    );
  }

  Widget _registerText(){
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context){
      return TextField(
        controller: _fullName,
        decoration: const InputDecoration(
          hintText: 'Full Name'
        ).applyDefaults(
          Theme.of(context).inputDecorationTheme
        ),
      );
  }

  Widget _emailField(BuildContext context){
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          hintText: 'Enter Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passField(BuildContext context){
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
          hintText: 'Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signinText(BuildContext context){
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15
                  ),
              ),
              TextButton(onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  LoginPage(),)
                );
              }, child: const Text("Login", style: TextStyle(fontSize: 15),))
            ],
          ),
        );
      }
    );
  }
}
