import 'package:flutter/material.dart';

import '../../../constant.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: descriptionStyle.copyWith(color: Colors.white, fontSize: 14),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: descriptionStyle.copyWith(
                        color: Colors.white, fontSize: 14, height: 1),
                    decoration: InputDecoration(
                      // fillColor: widget == null ? Colors.white : Colors.grey,
                      // filled: widget == null ? false : true,
                      hintText: hint,
                      border: InputBorder.none,
                      hintStyle: widget == null
                          ? descriptionStyle.copyWith(
                              color: Colors.grey, fontSize: 14, height: 1)
                          : descriptionStyle.copyWith(
                              color: Colors.black, fontSize: 14, height: 1),
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
