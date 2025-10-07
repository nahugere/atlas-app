import 'package:atlas/widgets/savedpopup.dart';
import 'package:atlas/widgets/searchpopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _initiated = false;
  bool _drawerOpen = false;

  void _toggleDrawer() {
    setState(() {
      _drawerOpen = !_drawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Main Body
          Positioned(
            top: MediaQuery.of(context).padding.top + 40,
            left: 0,
            child: NonInitiatedChatPage(),
          ),

          // Bottom Part
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                  color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      left: 17,
                      right: 17,
                      bottom: MediaQuery.of(context).padding.bottom + 15,
                      top: 5),
                  child: Row(
                    spacing: 12,
                    children: [
                      if (_initiated)
                        GestureDetector(
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: CupertinoActionSheet(
                                    actions: [
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print('Option 1 selected');
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Add an article',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Spacer(),
                                            Icon(CupertinoIcons.doc_append,
                                                color: Colors.black)
                                          ],
                                        ),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print('Option 1 selected');
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Add a saved article',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Spacer(),
                                            Icon(CupertinoIcons.bookmark,
                                                color: Colors.black)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            CupertinoIcons.plus,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                      Expanded(
                          child: CupertinoTextField(
                        placeholder: "Type your question here",
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        style: const TextStyle(fontSize: 16),
                        decoration: BoxDecoration(
                          color: CupertinoTheme.of(context)
                              .scaffoldBackgroundColor, // light grey bg
                          borderRadius: BorderRadius.circular(30), // pill shape
                          border: Border.all(
                            color: CupertinoColors.systemGrey4, // subtle border
                            width: 1.5,
                          ),
                        ),
                      )),
                      ClipOval(
                        child: GestureDetector(
                          child: Container(
                            width: 47,
                            height: 47,
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: Icon(
                              CupertinoIcons.paperplane_fill,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ))),

          // Nav Bar
          Positioned(
              top: 0,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 11 + MediaQuery.of(context).padding.top,
                    bottom: 11),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _toggleDrawer();
                      },
                      child: Container(
                        width: 22,
                        child: SvgPicture.asset(
                          'images/more_icon.svg',
                          semanticsLabel: 'Red dash paths',
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          // Drawer
          AnimatedOpacity(
              opacity: _drawerOpen ? 0.6 : 0,
              duration: Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: !_drawerOpen,
                child: GestureDetector(
                  onTap: () {
                    _toggleDrawer();
                  },
                  child: Container(
                    color: Colors.black,
                    child: SizedBox.expand(),
                  ),
                ),
              )),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: _drawerOpen
                ? MediaQuery.of(context).size.width * 0.15
                : MediaQuery.of(context).size.width + 250,
            top: 0,
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: EdgeInsets.only(
                  top: 11 + MediaQuery.of(context).padding.top, left: 16),
              decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  // Top part
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            _toggleDrawer();
                          },
                          child: Icon(
                            CupertinoIcons.xmark,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),

                  // History Part
                  Text("Chat History",
                      style:
                          GoogleFonts.dmSerifDisplay(fontSize: 34, height: 1.2))

                  // TODO 4: Implement chat history pooling
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NonInitiatedChatPage extends StatelessWidget {
  const NonInitiatedChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).padding.bottom + 145),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(),
            Text(
              "Hello,",
              style: GoogleFonts.dmSerifDisplay(
                  fontSize: 25, color: Color(0xFF797979)),
            ),
            Text("What's on your mind today?",
                style: GoogleFonts.dmSerifDisplay(fontSize: 37, height: 1.2)),
            SizedBox(
              height: 18,
            ),

            // Recommendation Box
            // TODO 1: Implement a randomly rotating suggestion box
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 14, bottom: 14, right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFE6E6E6)))),
                  child: Text(
                    "Why does Nepal have a triangular flag?",
                    style: GoogleFonts.workSans(fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 14, bottom: 14, right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFE6E6E6)))),
                  child: Text(
                    "What is Flutter?",
                    style: GoogleFonts.workSans(fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 14, bottom: 14, right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFE6E6E6)))),
                  child: Text(
                    "When did graphic cards emerge?",
                    style: GoogleFonts.workSans(fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 14, bottom: 14, right: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFE6E6E6)))),
                  child: Text(
                    "Can ducks swim underwater?",
                    style: GoogleFonts.workSans(fontSize: 16),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Two actions
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 16),
              child: Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoSheet(
                            context: context,
                            builder: (BuildContext modalContext) =>
                                SearchPopUp());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 17),
                        decoration: BoxDecoration(
                            color: Color(0xFFE4E4E4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          spacing: 4,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Icon(
                                  CupertinoIcons.doc_append,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Text(
                                  "Add an article",
                                  style: GoogleFonts.workSans(fontSize: 15),
                                )
                              ],
                            ),
                            Text(
                              "Attach an article to this chat",
                              style: GoogleFonts.workSans(
                                  fontSize: 14, color: Color(0xFF919191)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showCupertinoSheet(
                            context: context,
                            builder: (BuildContext modalContext) =>
                                SavedPopUp());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 17),
                        decoration: BoxDecoration(
                            color: Color(0xFFE4E4E4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          spacing: 4,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                Icon(
                                  CupertinoIcons.bookmark,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Text(
                                  "Saved articles",
                                  style: GoogleFonts.workSans(fontSize: 15),
                                )
                              ],
                            ),
                            Text(
                              "Attach a saved article to this chat",
                              style: GoogleFonts.workSans(
                                  fontSize: 14, color: Color(0xFF919191)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InitialStateWidget extends StatefulWidget {
  const InitialStateWidget({super.key});

  @override
  State<InitialStateWidget> createState() => _InitialStateWidgetState();
}

class _InitialStateWidgetState extends State<InitialStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text("Good Evening,"),
      ],
    );
  }
}
