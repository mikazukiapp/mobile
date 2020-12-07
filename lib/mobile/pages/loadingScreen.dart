import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mikazuki/mobile/pages/AniList/Overview.dart';
import 'package:mikazuki/mobile/pages/login.dart';
import 'package:mikazuki/mobile/widgets/util/NoAnimationMaterialPageRoute.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/GraphQLConfiguration.dart';
import 'package:mikazuki/shared/AniList/types/User.dart';

class LoadingScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingScreenWidget();
}

class _LoadingScreenWidget extends State<LoadingScreenWidget> {
  FlutterSecureStorage _secureStorage = new FlutterSecureStorage();

  _LoadingScreenWidget() {
    _secureStorage.read(key: 'anilist_token').then((token) async {
      if (token != null && token.isNotEmpty) {
        await _setAniListConfigurations(token);

        Navigator.of(context).pushAndRemoveUntil(NoAnimationMaterialPageRoute(builder: (context) => AniListOverviewWidget()), (route) => false);
      } else {
        Navigator.of(context).pushReplacement(
          NoAnimationMaterialPageRoute(builder: (context) => LoginScreenWidget()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _setAniListConfigurations(String token) async {
    GraphQLConfiguration.setToken(token);
    AniListRepository.getInstance().isLoggedIn = true;

    AniListUser user = await AniListRepository.getInstance().getUserData();
    AniListRepository.getInstance().username = user.name;
  }
}
