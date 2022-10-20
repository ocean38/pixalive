import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pixalive/utils/app_colors.dart';
import 'package:pixalive/utils/app_images.dart';
import 'package:pixalive/utils/app_prefrences.dart';
import 'package:pixalive/utils/app_routes.dart';
import 'package:pixalive/utils/app_textstyles.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  final List<Widget> _pageViewList = <Widget>[
    Pages(title: "Page 1"),
    Pages(title: "Page 2"),
    Pages(title: "Page 3"),
  ];

  int _currentPage = 0;
  Timer? _timer;

  void _automaticScroll() {
    int page = 0;
    _timer = Timer.periodic(
      Duration(seconds: 2),
      (Timer timer) {
        _controller.animateToPage(
          ++page,
          duration: Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    AppPrefrences.setIsTutorialVisited();
    _automaticScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onLongPressStart: (LongPressStartDetails _) {
          _timer?.cancel();
        },
        onLongPressEnd: (LongPressEndDetails _) {
          _automaticScroll();
        },
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index % _pageViewList.length;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _pageViewList[index % _pageViewList.length];
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: List.generate(
                        _pageViewList.length,
                        (int index) => _indicator(index),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pageViewList.length - 1) {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.welcomePage,
                          );
                        } else {
                          setState(() {
                            _currentPage++;
                          });
                          _controller.animateToPage(
                            _currentPage,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 15.0,
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.salmon,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      child: Text(
                        (_currentPage == _pageViewList.length - 1)
                            ? "Get Started"
                            : "Next",
                        style: AppTextStyle.white18W400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer _indicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      height: 8.0,
      width: (_currentPage == index) ? 25 : 7,
      margin: EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Colors.grey,
      ),
    );
  }
}

class Pages extends StatelessWidget {
  final String title;

  const Pages({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              AppImages.onBoardingScreen,
              height: MediaQuery.of(context).size.width * 0.90,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Text(
              title,
              style: AppTextStyle.black24W700,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the the printing and typesetting industry. Lorem Ipsum has been the industry.",
              style: AppTextStyle.grey18Shade700,
            ),
          ],
        ),
      ),
    );
  }
}
