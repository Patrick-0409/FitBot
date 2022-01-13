import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/signup/components/dob_selector.dart';
import 'package:fiton/screen/authentication/signup/components/gender_selector.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/screen/workout/kuisoner/components/text_field.dart';
import 'package:fiton/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/text_field.dart';

class WorkoutScreen extends StatefulWidget {
  final String? payload;

  const WorkoutScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  var loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmailSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;

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
                  "Workout Plan",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.black, fontSize: 22),
                ),
                Spacer(),
                HomeButton(),
              ],
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Before we start,",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "Let's fill some missing things",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: size.height * 0.5,
                    width: size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kBackgroundColor,
                        width: 1,
                      ),
                      color: kBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 10, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DobSelector(),
                          SizedBox(height: 5),
                          GenderSelector(),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              TextFieldd(
                                label: 'Weight (kg)',
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                size: size,
                                validator: _requiredWeight,
                              ),
                              const SizedBox(height: 15),
                              Spacer(),
                              TextFieldd(
                                label: 'Height (cm)',
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                size: size,
                                validator: _requiredHeight,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "The data you provide will be used to adapt our training plan based on your input",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  if (loading) ...[
                    Center(child: CircularProgressIndicator()),
                  ],
                  if (!loading) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: RoundedButton(
                        text: "Submit",
                        press: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            provider.weight = _weightController.text;
                            provider.height = _heightController.text;
                            String temp = await provider.save(user.uid);
                            // print(user.uid);
                            await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Submit succeeded'),
                                      content: Text(
                                          'Thank you for completing your data!'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'))
                                      ],
                                    ));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ));
  }

  String? _requiredWeight(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required';
    }
    if (int.parse(text) < 5) {
      return "Enter weight correctly!";
    }
    if (int.parse(text) > 300) {
      return "Enter weight correctly!";
    }
    return null;
  }

  String? _requiredHeight(String? text) {
    if (text == null || text.trim().isEmpty) {
      return 'This field is required!';
    }
    if (int.parse(text) < 5) {
      return "Enter height correctly!";
    }
    if (int.parse(text) > 300) {
      return "Enter height correctly!";
    }
    return null;
  }
}
