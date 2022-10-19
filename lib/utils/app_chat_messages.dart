import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class Message extends StatelessWidget {
  final String? message;
  final String? time;
  final bool? isMe;

  const Message({
    Key? key,
    required this.message,
    required this.time,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment:
            (isMe ?? false) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          if (isMe ?? false)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: AppColor.gradientColor,
                        stops: [0, 0.3, 1],
                      ),
                    ),
                    child: Text(
                      message ?? "",
                      style: AppTextStyle.white16,
                    ),
                  ),
                  SizedBox(height: _screenSize.height / 120),
                  Text(
                    time!.substring(0, 5) + " " + time!.substring(8),
                    style: AppTextStyle.blueGrey16,
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message ?? "",
                      style: AppTextStyle.black16,
                    ),
                  ),
                  SizedBox(height: _screenSize.height / 120),
                  Text(
                    time!.substring(0, 5) + " " + time!.substring(8),
                    style: AppTextStyle.blueGrey16,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
