import 'package:copyify/common/widgets/buttons/basic_app_button.dart';
import 'package:copyify/core/configs/assets/app_images.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/presentation/modes/pages/choose_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/assets/app_vectors.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.introBg
                )
              )
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 40
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                      AppVectors.logo
                  ),
                ),
                const Spacer(),
                const Text(
                  "Enjoy Listening to Music",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22
                  ),
                ),
                const SizedBox(height: 21,),
                const Text(
                  "Copify is your personal music hub, offering a seamless streaming experience. Discover millions of songs, create personalized playlists, and enjoy high-quality audio on your favorite devices.",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray,
                      fontSize: 15
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20,),
                BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const ModeChoose(),)
                      );
                    },
                    title: "Get Started"
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
