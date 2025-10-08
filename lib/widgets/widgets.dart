import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TapWithHapticFeedback extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final int intensity;
  const TapWithHapticFeedback(
      {super.key,
      required this.onTap,
      required this.child,
      this.intensity = 1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (intensity < 1) {
          HapticFeedback.lightImpact();
        } else if (intensity >= 1 && intensity < 2) {
          HapticFeedback.mediumImpact();
        } else {
          HapticFeedback.heavyImpact();
        }
        onTap();
      },
      child: child,
    );
  }
}

class ATabBar extends StatefulWidget {
  final bool selected;
  final String val;
  final GestureTapCallback onTap;
  const ATabBar(
      {super.key,
      required this.selected,
      required this.val,
      required this.onTap});

  @override
  State<ATabBar> createState() => _ATabBarState();
}

class _ATabBarState extends State<ATabBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
          duration: Duration(microseconds: 500),
          decoration: BoxDecoration(
              border: Border(
                  bottom: widget.selected
                      ? BorderSide(color: Color(0xFF1D7D53), width: 2)
                      : BorderSide.none)),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 9),
          child: Text(
            widget.val,
            style: GoogleFonts.workSans(
                fontSize: 15,
                color: widget.selected ? Color(0xFF1D7D53) : Color(0xFF727272)),
          )),
    );
  }
}

class ASearchBar extends StatelessWidget {
  final TextEditingController controller;
  const ASearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 8),
      height: 46,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 5, top: 6),
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(4))),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(right: 5),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.5, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: CupertinoTextField(
                padding: EdgeInsets.only(left: 8, bottom: 5),
                controller: controller,
                prefix: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                    size: 17,
                  ),
                ),
                placeholderStyle: GoogleFonts.workSans(
                    fontSize: 15, color: Color(0xFF919191)),
                placeholder: "Search for articles, ask questions, ...",
              )),
        ],
      ),
    );
  }
}

class ATileShimmer extends StatelessWidget {
  const ATileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.only(left: 10, top: 16.5, bottom: 20, right: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: 1.5))),
      child: Row(
        spacing: 20,
        children: [
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer(
                  color: Colors.grey.shade600,
                  child: Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                Shimmer(
                  color: Colors.grey.shade600,
                  child: Container(
                    width: 200,
                    height: 16,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Shimmer(
                  color: Colors.grey.shade600,
                  child: Container(
                    width: 50,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ],
            ),
          ),
          Shimmer(
            color: Colors.grey.shade600,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          )
        ],
      ),
    );
  }
}

class ATile extends StatelessWidget {
  final String title;
  final String readTime;
  final String source;
  final String img;
  final GestureTapCallback onTap;
  const ATile(
      {super.key,
      required this.title,
      required this.readTime,
      required this.source,
      required this.img,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.only(left: 10, top: 16.5, bottom: 20, right: 16),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 1.5))),
        child: Row(
          spacing: 20,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.dmSerifText(fontSize: 15),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        readTime == "" ? "$source" : "$source | $readTime",
                        style: GoogleFonts.workSans(
                            fontSize: 13, color: Color(0xFF878787)),
                      )),
                      // Text(
                      //   "Summarize",
                      //   style: GoogleFonts.workSans(
                      //       fontSize: 13, color: Color(0xFF878787)),
                      // )
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 55,
              width: 55,
              child: img == ""
                  ? Text("${source[0]}",
                      style: GoogleFonts.dmSerifText(fontSize: 30))
                  : Container(),
              decoration: img == ""
                  ? BoxDecoration(
                      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                      border: BoxBorder.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)))
                  : BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(img), fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
            )
          ],
        ),
      ),
    );
  }
}
