import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/common/widgets/buttons/basic_app_button.dart';
import 'package:copyify/core/configs/assets/app_vectors.dart';
import 'package:copyify/data/models/auth/login_user_req.dart';
import 'package:copyify/domain/usecases/auth/login.dart';
import 'package:copyify/presentation/auth/pages/register_page.dart';
import 'package:copyify/presentation/home/pages/home.dart';
import 'package:copyify/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
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
            SizedBox(height: 60,),
            _emailField(context),
            SizedBox(height: 25,),
            _passField(context),
            SizedBox(height: 30,),
            BasicAppButton(
                onPressed: () async{
                  var result = await sl<LoginUseCase>().call(
                      params: LoginUserRequest(
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
                title: "Sign In"
            )
          ],
        ),
      ),
    );
  }

  Widget _registerText(){
    return Text(
      "Sign In",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context){
    return TextField(
      controller: _email,
      decoration: InputDecoration(
          hintText: 'Enter Email'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _passField(BuildContext context){
    return TextField(
      controller: _password,
      decoration: InputDecoration(
          hintText: 'Password'
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _signupText(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15
            ),
          ),
          TextButton(onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  RegisterPage(),)
            );
          }, child: Text("Register now", style: TextStyle(fontSize: 15),))
        ],
      ),
    );
  }
}
