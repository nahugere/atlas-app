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

  List<String> recs = [];
  bool showAIButton = false;
  bool loading = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // searchController.addListener(() async {
    //   if (searchController.text != "" && searchQuery == "") {
    //     var r = await _webService.getSuggestions(searchController.text);
    //     setState(() {
    //       recs = r;
    //     });
    //   }
    // });
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
        child: Column(
          children: [
            // Search bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Hero(
                tag: 'searchHero',
                child: ASearchBar(
                  controller: searchController,
                  focusNode: focusNode,
                  enabled: true,
                  onChanged: (e) async {
                    List<String> r = [];
                    if (e != "") {
                      r = await _webService.getSuggestions(e!);
                    }
                    setState(() {
                      recs = r;
                      if (searchQuery != "") {
                        searchQuery = "";
                      }
                    });
                  },
                ),
              ),
            ),

            // Display
            Expanded(
              child: ListView(
                children: [
                  if (searchQuery == "" && recs.isNotEmpty)
                    for (var i in recs)
                      SuggestionWidget(i, onTap: () {
                        setState(() {
                          searchQuery = i;
                          searchController.text = i;
                          loading = true;
                          focusNode.unfocus();
                        });
                      }),
                  if (searchQuery != "")
                    FutureBuilder(
                        future: _webService.search(searchQuery),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Column(
                              children: [
                                for (var i = 0; i <= 5; i++) ATileShimmer()
                              ],
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData == true) {
                            return Column(
                              children: [
                                if (snapshot.data?["articles"] != [])
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Articles",
                                          style: GoogleFonts.workSans(
                                            fontSize: 14,
                                          )),
                                      for (var i in snapshot.data?["articles"])
                                        ATile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                              return DetailPage(
                                                title: i["title"],
                                                category: i["category"],
                                                img: i["img"] == null
                                                    ? ""
                                                    : i["img"],
                                                url: i["url"],
                                                source: i["source"],
                                                date: i["date"],
                                                wikiDetail:
                                                    i["source"] == "Wikipedia"
                                                        ? i["id"].toString()
                                                        : "",
                                                readTime: i["readTime"] == null
                                                    ? null
                                                    : "${i["readTime"].toStringAsFixed(0)} Min",
                                                description:
                                                    i["description"] == null
                                                        ? null
                                                        : i["description"],
                                              );
                                            }));
                                          },
                                          title: i["title"],
                                          readTime: i["readTime"] == null
                                              ? ""
                                              : "${i["readTime"].toStringAsFixed(0)} Min read",
                                          source: i["source"],
                                          img: i["img"] == null ? "" : i["img"],
                                        )
                                    ],
                                  ),
                                if (snapshot.data?["news"] != [])
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("News",
                                          style: GoogleFonts.workSans(
                                            fontSize: 14,
                                          )),
                                      for (var i in snapshot.data?["news"])
                                        ATile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                    builder: (context) {
                                              return DetailPage(
                                                title: i["title"],
                                                category: i["category"],
                                                img: i["img"] == null
                                                    ? ""
                                                    : i["img"],
                                                url: i["url"],
                                                source: i["source"],
                                                date: i["date"],
                                                wikiDetail:
                                                    i["source"] == "Wikipedia"
                                                        ? i["id"].toString()
                                                        : "",
                                                readTime: i["readTime"] == null
                                                    ? null
                                                    : "${i["readTime"].toStringAsFixed(0)} Min",
                                                description:
                                                    i["description"] == null
                                                        ? null
                                                        : i["description"],
                                              );
                                            }));
                                          },
                                          title: i["title"],
                                          readTime: i["readTime"] == null
                                              ? ""
                                              : "${i["readTime"].toStringAsFixed(0)} Min read",
                                          source: i["source"],
                                          img: i["img"] == null ? "" : i["img"],
                                        )
                                    ],
                                  ),
                              ],
                            );
                          }

                          return Text("ge");
                        })
                ],
              ),
            ),

            // if (searchQuery == "" && searchController.text != "") Container()
            // Expanded(
            //     child: FutureBuilder(
            //         future:
            //             _webService.getSuggestions(searchController.text),
            //         builder: (context, snapshot) {
            //           if (snapshot.connectionState ==
            //               ConnectionState.done) {
            //             return ListView(
            //               children: [
            //                 for (var i in snapshot.data!)
            //                   Container(
            //                     padding: EdgeInsets.symmetric(
            //                         vertical: 20, horizontal: 15),
            //                     child: Text(i),
            //                   )
            //               ],
            //             );
            //           }
            //           return Text("Start searching man");
            //         }))

            // Search with AI button
            if (showAIButton)
              Positioned(bottom: 0, left: 0, right: 0, child: AISearch())
          ],
        ));
  }
}

class SuggestionWidget extends StatefulWidget {
  final String suggestion;
  final Function onTap;
  const SuggestionWidget(this.suggestion, {super.key, required this.onTap});

  @override
  State<SuggestionWidget> createState() => _SuggestionWidgetState();
}

class _SuggestionWidgetState extends State<SuggestionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onTap(),
        child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 17),
            padding: EdgeInsets.only(left: 15, right: 17, bottom: 15, top: 15),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.black))),
            child: Row(
              children: [
                Expanded(child: Text(widget.suggestion)),
                Icon(
                  CupertinoIcons.arrow_up_left_circle_fill,
                  size: 15,
                  color: Colors.black,
                )
              ],
            )));
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
