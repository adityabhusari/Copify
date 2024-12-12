import 'package:copyify/common/helpers/is_dark_extension.dart';
import 'package:copyify/common/widgets/appbar/appbar.dart';
import 'package:copyify/core/configs/assets/app_images.dart';
import 'package:copyify/core/configs/assets/app_vectors.dart';
import 'package:copyify/core/configs/theme/app_colors.dart';
import 'package:copyify/presentation/home/widgets/news_songs.dart';
import 'package:copyify/presentation/home/widgets/playlist.dart';
import 'package:copyify/presentation/profile/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        action: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
            },
            icon: Icon(
              Icons.person
            )
        ),
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              _homeTopCard(),
              _tabs(),
              SizedBox(
                height: 260,
                child: TabBarView(
                    controller: _tabController,
                    children: [
                        NewsSongs(),
                      Container(),
                      Container(),
                      Container()
                    ]
                ),
              ),
            PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 65
                ),
                child: Image.asset(
                  AppImages.homeTopArtist
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _tabs() {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.only(
        right: 50
      ),
      child: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          isScrollable: true,
          labelColor: context.isDark ? Colors.white : Colors.black,
          indicatorColor: AppColors.primary,
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
          ),
          tabs: const [
            Text("News", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            Text("Videos",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            Text("Artists",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
            Text("Podcasts",  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
        ]
      ),
    );
  }
}
