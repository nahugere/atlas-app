import 'package:atlas/pages/detailpage.dart';
import 'package:atlas/services/webService.dart';
import 'package:atlas/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final WebService _webService = WebService();

  bool showAIButton = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // searchCont
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          trailing: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: CupertinoTheme.of(context).primaryColor),
            ),
          ),
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          automaticBackgroundVisibility: false,
          enableBackgroundFilterBlur: false,
          middle: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Text(
              "Search Articles",
              style: GoogleFonts.dmSerifText(
                  fontSize: 19, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                  child: Hero(
                    tag: 'searchHero',
                    child: ASearchBar(
                      controller: searchController,
                      focusNode: focusNode,
                      enabled: true,
                    ),
                  ),
                ),
                if (searchQuery == "")
                  Expanded(
                      child: FutureBuilder(
                          future:
                              _webService.getSuggestions(searchController.text),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView(
                                children: [
                                  for (var i in snapshot.data!)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 15),
                                      child: Text(i),
                                    )
                                ],
                              );
                            }
                            return Text("Start searching man");
                          }))
              ],
            ),
            if (showAIButton)
              Positioned(bottom: 0, left: 0, right: 0, child: AISearch())
          ],
        ));
  }
}

class AISearch extends StatelessWidget {
  const AISearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 17,
          right: 17,
          top: 17,
          bottom: MediaQuery.of(context).padding.bottom + 17),
      decoration: BoxDecoration(
          color: Color(0xFFE4E4E4),
          border: BoxBorder.fromLTRB(
              top: BorderSide(color: Colors.black, width: 2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          Text(
            "Didn't find what you were looking for?",
            style: GoogleFonts.dmSerifText(
                fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Container(
            width: 174,
            child: KButton(
              icon: SvgPicture.asset(
                'images/middle_icon.svg',
                width: 26,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => print("hhh"),
              text: "Search with AI",
            ),
          )
        ],
      ),
    );
  }
}
