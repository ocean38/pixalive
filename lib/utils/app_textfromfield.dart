// This file contains all the TextFromFiels of the application

import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_textstyles.dart';

//
//--------------------Common Text Form Field--------------------
//
class AppTextFormField extends StatefulWidget {
  final FocusNode? focusNodeName;
  final validatorName;
  final FocusNode? nextFocus;
  final Function(String?)? onSavedFun;
  final TextEditingController? controller;
  final String? labelText;
  final bool? isPassword;
  final Widget? suffixButton;
  final Function? onTap;
  final bool? isEditable;

  const AppTextFormField({
    Key? key,
    this.focusNodeName,
    this.validatorName,
    this.nextFocus,
    this.onSavedFun,
    this.controller,
    this.labelText,
    this.isPassword = false,
    this.suffixButton,
    this.onTap,
    this.isEditable,
  }) : super(key: key);

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _showPassword = false;

  @override
  void initState() {
    if (widget.isPassword!) _showPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          enabled: widget.isEditable,
          // inputFormatters: <TextInputFormatter>[
          //   FilteringTextInputFormatter.deny(RegExp("[ `~]")),
          // ],
          focusNode: widget.focusNodeName,
          validator: widget.validatorName,
          obscureText: _showPassword,
          onSaved: widget.onSavedFun,
          controller: widget.controller,
          autofocus: true,
          textInputAction: widget.nextFocus != null
              ? TextInputAction.next
              : TextInputAction.done,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(widget.nextFocus);
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.salmon,
              ),
            ),
            labelText: widget.labelText,
            labelStyle: AppTextStyle.grey20Shade700,
            suffixIcon: widget.isPassword ?? false
                ? IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    color: _showPassword ? Colors.grey : Colors.black,
                    onPressed: () {
                      setState(() => _showPassword = !_showPassword);
                    },
                  )
                : widget.suffixButton == null
                    ? null
                    : widget.suffixButton,
          ),
        ),
        // Container(
        //   height: 1,
        //   width: MediaQuery.of(context).size.width,
        //   decoration: BoxDecoration(
        //     gradient: widget.focusNodeName.hasFocus
        //         ? LinearGradient(
        //             colors: [Colors.black],
        //           )
        //         : LinearGradient(
        //             colors: AppColor.gradientColor,
        //             stops: [0, 0.5, 1],
        //           ),
        //   ),
        // ),
      ],
    );
  }
}

//
//--------------------OTP Boxes-------------------
//
class GetOtp extends StatelessWidget {
  final FocusNode? focusNodeName;
  final FocusNode? nextFocus;
  final TextEditingController? controller;

  const GetOtp({
    Key? key,
    this.focusNodeName,
    this.nextFocus,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      width: MediaQuery.of(context).size.width * 0.12,
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextFormField(
        maxLength: 1,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15, top: 11, right: 15),
          counterText: "",
          border: InputBorder.none,
        ),
        controller: controller,
        focusNode: focusNodeName,
        onChanged: (val) {
          if (val.length == 1) {
            focusNodeName?.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        keyboardType: TextInputType.phone,
        textInputAction:
            nextFocus != null ? TextInputAction.next : TextInputAction.done,
      ),
    );
  }
}

//
//--------------------chat textFromFiels-------------------
//
class ChatTextFromField extends StatelessWidget {
  final TextEditingController? messageController;

  const ChatTextFromField({
    Key? key,
    this.messageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Start Typing..",
                  contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.025),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 50),
              width: 1,
              height: MediaQuery.of(context).size.height * 0.02,
              child: VerticalDivider(color: Colors.blueGrey),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.02,
              width: MediaQuery.of(context).size.width / 7,
              child: ElevatedButton(
                onPressed: () {},
                child: Image.asset(AppImages.chatAttachement),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(CircleBorder()),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
