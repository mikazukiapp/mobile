import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mikazuki/mobile/pages/login.dart';
import 'package:mikazuki/mobile/pages/search.dart';
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
        _setAniListConfigurations(token);

        Navigator.of(context).pushAndRemoveUntil(NoAnimationMaterialPageRoute(builder: (context) => SearchScreenWidget()), (route) => false);
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

  void _setAniListConfigurations(String token) {
    GraphQLConfiguration.setToken(token);
    AniListRepository.getInstance().isLoggedIn = true;

    AniListRepository.getInstance().getUserData().then((AniListUser user) {
      AniListRepository.getInstance().username = user.name;
    });
  }
}
