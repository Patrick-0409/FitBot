import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String trending_url =
    'https://newsapi.org/v2/top-headlines?category=health&q=kesehatan&apiKey=e08220ae586347369accb7f48b746c39';
const String training_url =
    'https://newsapi.org/v2/everything?q=olahraga sehat&apiKey=e08220ae586347369accb7f48b746c39';
const String food_url =
    'https://newsapi.org/v2/everything?q=makanan sehat&apiKey=e08220ae586347369accb7f48b746c39';
const String diet_url =
    'https://newsapi.org/v2/everything?q=diet sehat&apiKey=e08220ae586347369accb7f48b746c39';

const String apiKey = "AIzaSyC0_N9rxMEYDCPiQva-dqDhHVHnDg9I7Bc";

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
const kArticle = Color(0xFFFDD1C3);
const kTrain = Color(0xFFD8FFD4);
const kChat = Color(0xFFC3F2FD);
const kArticleText = Color(0XFFDA3B3B);
const kTrainText = Color(0XFF579823);
const kChatText = Color(0XFF3B71DA);
const kGender = Color(0XFF7E9ACF);
const kWeight = Color(0XFFE9A464);
const kProfile = Color(0XFF57A3A8);
const kPip = Color(0XFF8EB3B6);
const kStastC = Color(0XFF2B5558);
const kSearchBarColor = Color(0xFF979797);
const KEatCardCategory = Color(0XFF9FC9DB);
const KEatCardCalories = Color(0XFFDFB472);
const KEatCardBackground = Color(0XFFD7D3D3);

const kDefaultPaddin = 20.0;

var kNonActiveTabStyle = GoogleFonts.poppins(
  textStyle: TextStyle(fontSize: 14.0, color: kGrey1),
);

var kArticleTitle = GoogleFonts.poppins(
  textStyle: TextStyle(fontSize: 15.0, color: kArticleText),
);

var kTrainTitle = GoogleFonts.poppins(
  textStyle: TextStyle(fontSize: 15.0, color: kTrainText),
);

var kChatTitle = GoogleFonts.poppins(
  textStyle: TextStyle(fontSize: 15.0, color: kChatText),
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

var kTitleCardEat = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 10.0,
    color: kBlack,
    fontWeight: FontWeight.bold,
  ),
);

var kDistanceTitle = GoogleFonts.poppins(
  textStyle: TextStyle(
    fontSize: 12.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

var descriptionStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
  fontSize: 15.0,
  height: 2.0,
));
