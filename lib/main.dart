import 'package:atlas/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const Atlas());
}

class Atlas extends StatelessWidget {
  const Atlas({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF1D7D53),
          scaffoldBackgroundColor: Color(0xffF5F5F5)),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _curIndex = 0;
  List<Widget> _navStack = [HomePage(), SavedPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(
      children: [
        // Page
        IndexedStack(
          index: _curIndex,
          children: _navStack,
        ),

        // Bottom Navigation bar
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60 + MediaQuery.of(context).padding.bottom,
              color: CupertinoTheme.of(context).scaffoldBackgroundColor,
              // decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //       Color.fromARGB(0, 245, 245, 245),
              //       Color(0xffF5F5F5),
              //       Color(0xffF5F5F5)
              //     ])),
              padding: EdgeInsets.only(
                  bottom: 17 + MediaQuery.of(context).padding.bottom,
                  top: 10,
                  left: 18,
                  right: 18),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _curIndex = 0;
                          });
                        },
                        child: SizedBox(
                          width: 300,
                          child: Icon(
                            CupertinoIcons.house,
                            color: _curIndex == 0
                                ? CupertinoTheme.of(context).primaryColor
                                : Color(0xFF878787),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: (context) {
                            return ChatPage();
                          }));
                        },
                        child: SvgPicture.asset(
                          'images/middle_icon.svg',
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _curIndex = 1;
                          });
                        },
                        child: Icon(CupertinoIcons.bookmark,
                            color: _curIndex == 1
                                ? CupertinoTheme.of(context).primaryColor
                                : Color(0xFF878787)),
                      )),
                ],
              ),
            ))
      ],
    ));
  }
}
