import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/common/widgets/buttons/basic_app_button.dart';
import 'package:copyify/core/configs/assets/app_images.dart';
import 'package:copyify/core/configs/assets/app_vectors.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/presentation/auth/pages/login_page.dart';
import 'package:copyify/presentation/auth/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthChoose extends StatelessWidget {
  const AuthChoose({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              AppVectors.topPattern
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
                AppVectors.bottomPattern
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
                AppImages.authBg
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 35,
                horizontal: 35
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppVectors.logo
                  ),
                  const SizedBox(height: 40,),
                  const Text(
                      "Enjoy Listening To Music",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                  ),
                  const SizedBox(height: 30,),
                  const Text(
                    "Copify is a propietary Indian audio streaming and media services provider",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.gray
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  RegisterPage(),)
                                );
                              },
                              title: "Register"
                          )
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  LoginPage(),)
                              );
                            },
                            child:  Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: context.isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
