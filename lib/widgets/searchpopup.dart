import 'package:atlas/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPopUp extends StatefulWidget {
  const SearchPopUp({super.key});

  @override
  State<SearchPopUp> createState() => _SearchPopUpState();
}

class _SearchPopUpState extends State<SearchPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Drag Indicator
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 30),
                  child: Container(
                    width: 35,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(69, 60, 60, 67),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Text("Search Articles",
                    style:
                        GoogleFonts.dmSerifDisplay(fontSize: 37, height: 1.2)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                child: ASearchBar(
                  enabled: true,
                  controller: TextEditingController(),
                  focusNode: FocusNode(),
                ),
              ),

              // TODO 2: Implement search mechanism here
            ]));
  }
}
