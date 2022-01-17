import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiton/constant.dart';
import 'package:fiton/screen/authentication/components/rounded_button.dart';
import 'package:fiton/screen/authentication/components/text_field_container.dart';
import 'package:fiton/screen/authentication/signup/components/dob_selector.dart';
import 'package:fiton/screen/authentication/signup/components/gender_selector.dart';
import 'package:fiton/screen/homepage/home_screen.dart';
import 'package:fiton/screen/provider/email_auth.dart';
import 'package:fiton/screen/scheduler/Form/input_field.dart';
import 'package:fiton/screen/workout/Train/components/home_button.dart';
import 'package:fiton/screen/workout/Train/train_screen.dart';
import 'package:fiton/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/text_field.dart';

class KuisonerScreen extends StatefulWidget {
  const KuisonerScreen({Key? key}) : super(key: key);

  @override
  _KuisonerScreenState createState() => _KuisonerScreenState();
}

class _KuisonerScreenState extends State<KuisonerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectIntensity = "Sedentary";
  List<String> intensityList = [
    "Sedentary",
    "1-3 Times a week",
    "4-5 Times a week",
    "Daily",
  ];
  String _selectTarget = "Maintain";
  List<String> targetList = [
    "Maintain",
    "Mild Weight loss",
    "Normal Weight Loss",
    "Extreme Weight Loss",
  ];
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
                "Personal Form",
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
                SizedBox(height: 5),
                Container(
                  height: size.height * 0.64,
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
                        left: 10.0, right: 10, top: 5, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Birthday",
                          textAlign: TextAlign.center,
                          style: descriptionStyle.copyWith(
                              color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 3),
                        DobSelector(),
                        Text(
                          "Gender",
                          textAlign: TextAlign.center,
                          style: descriptionStyle.copyWith(
                              color: Colors.white, fontSize: 14),
                        ),
                        GenderSelector(),
                        Row(
                          children: [
                            Text(
                              "Weight",
                              textAlign: TextAlign.center,
                              style: descriptionStyle.copyWith(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Spacer(),
                            Text(
                              "Height",
                              textAlign: TextAlign.center,
                              style: descriptionStyle.copyWith(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            TextFieldd(
                              label: 'Weight (kg)',
                              controller: _weightController,
                              keyboardType: TextInputType.number,
                              size: size,
                              validator: _requiredWeight,
                            ),
                            Spacer(),
                            TextFieldd(
                              label: 'Height (cm)',
                              controller: _heightController,
                              keyboardType: TextInputType.number,
                              size: size,
                              validator: _requiredHeight,
                            ),
                          ],
                        ),
                        InputField(
                          title: "How active are you ?",
                          hint: "$_selectIntensity",
                          widget: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: DropdownButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 22,
                              elevation: 4,
                              style: descriptionStyle.copyWith(
                                  color: Colors.grey, fontSize: 14, height: 2),
                              underline: Container(height: 0),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectIntensity = newValue!;
                                });
                              },
                              items: intensityList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        InputField(
                          title: "What do you want FitBot for ?",
                          hint: "$_selectTarget",
                          widget: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: DropdownButton(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 22,
                              elevation: 4,
                              style: descriptionStyle.copyWith(
                                  color: Colors.grey, fontSize: 14, height: 2),
                              underline: Container(height: 0),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectTarget = newValue!;
                                });
                              },
                              items: targetList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "The data you provide will be used to adapt our application based on your input",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                if (loading) ...[
                  Center(child: CircularProgressIndicator()),
                ],
                if (!loading) ...[
                  RoundedButton(
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
                        Navigator.pop(context, true);
                      }
                    },
                    wid: size.width * 0.93,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
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
