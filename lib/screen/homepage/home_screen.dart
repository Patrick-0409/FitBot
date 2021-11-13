import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/screen/authentication/login/login_screen.dart';
import 'package:fiton/screen/profile/profile_screen.dart';
import 'package:fiton/services/geolocator_service.dart';
import 'package:fiton/services/places_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  Future<void> _signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
  
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(66.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfileScreen();
                      },
                    ),
                  );
                },
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
              ),
              title: Text(
                "FitBot",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: GestureDetector(
                onTap: () {
                  _signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
                child: SvgPicture.asset("assets/images/menu.svg"),
              ),
            ),
          ],
        ),
      ),
      body: Body()
    );
  }
}
