import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String trending_url = 'https://newsapi.org/v2/top-headlines?category=health&q=kesehatan&apiKey=e08220ae586347369accb7f48b746c39';
String training_url = 'https://newsapi.org/v2/everything?q=olahraga sehat&apiKey=e08220ae586347369accb7f48b746c39';
String food_url = 'https://newsapi.org/v2/everything?q=makanan sehat&apiKey=e08220ae586347369accb7f48b746c39';
String diet_url = 'https://newsapi.org/v2/everything?q=diet sehat&apiKey=e08220ae586347369accb7f48b746c39';

const kHeaderColor = Color(0xFF39BBC3);
const kTextLightColor = Color(0xFFACACAC);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kFacebookColor = Color(0xFF3B5998);
const kLoginColor = Color(0xFF3B7C81);
const kBackgroundColor = Color(0xFF295677);
const kGrey1 = Color(0xFF9F9F9F);
const kGrey2 = Color(0xFF6D6D6D);
const kGrey3 = Color(0xFFEAEAEA);
const kBlack = Color(0xFF1C1C1C);
const kTagColor = Color(0xFF39BBC4);

const kDefaultPaddin = 20.0;

var kNonActiveTabStyle = GoogleFonts.poppins(
  textStyle: TextStyle(fontSize: 14.0, color: kGrey1),
);

var kActiveTabStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 16.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var kCategoryTitle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
    fontWeight: FontWeight.bold,
  ),
);

var kDetailContent = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: kGrey2,
  ),
);

var kTitleCard = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 18.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var descriptionStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
  fontSize: 15.0,
  height: 2.0,
));
