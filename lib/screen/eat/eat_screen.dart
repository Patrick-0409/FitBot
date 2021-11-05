import 'package:favorite_button/favorite_button.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';
import 'components/favorite_eat_screen.dart';
import 'detail/components/circle_button.dart';

class EatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "FitBot",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
              Spacer(),
              CircleButton(
                icon: Icons.favorite,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FavoriteEatScreen();
                      },
                    ),
                  );
                },
                color: Colors.red,
              ),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Body(),
    );
  }
}
