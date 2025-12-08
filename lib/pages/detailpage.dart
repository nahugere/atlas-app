import 'package:atlas/services/webService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  final String title;
  final String? img;
  final String? description;
  final String? date;
  final String? readTime;
  final String? wikiDetail;
  final String source;
  final String category;
  final String url;
  const DetailPage(
      {super.key,
      required this.title,
      this.img,
      required this.url,
      this.description,
      this.date,
      this.readTime,
      this.wikiDetail,
      required this.source,
      required this.category});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  WebService _webService = WebService();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
          automaticBackgroundVisibility: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.arrow_left,
              size: 23,
              color: Colors.black,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {},
            child: Icon(
              CupertinoIcons.bookmark,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: FutureBuilder(
                  future: _webService.getDetailFeed(
                      widget.source, widget.category, widget.wikiDetail),
                  builder: (context, asyncSnapshot) {
                    return ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        MainBody(widget: widget),
                        Container(
                          width: double.infinity,
                          height: 470,
                          decoration: BoxDecoration(
                              color: Color(0xFFE4E4E4),
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black, width: 2))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 14.0, bottom: 18.0, left: 25),
                                child: Text("Similar Articles",
                                    style: GoogleFonts.dmSerifText(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Expanded(
                                  child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 25,
                                  ),
                                  // Article
                                  Container(
                                    margin: EdgeInsets.only(right: 6),
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 170,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF9D9D9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(13))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, ...",
                                              maxLines: 2,
                                              style: GoogleFonts.dmSerifText(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Text("Source",
                                            style: GoogleFonts.workSans(
                                                color: Color(0xFF717171),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 170,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF9D9D9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(13))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, ...",
                                              maxLines: 2,
                                              style: GoogleFonts.dmSerifText(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Text("Source",
                                            style: GoogleFonts.workSans(
                                                color: Color(0xFF717171),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    width: 170,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 170,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF9D9D9D),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(13))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          child: Text(
                                              "Lorem ipsum dolor sit amet, ...",
                                              maxLines: 2,
                                              style: GoogleFonts.dmSerifText(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                        Text("Source",
                                            style: GoogleFonts.workSans(
                                                color: Color(0xFF717171),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 10,
                                  )
                                ],
                              ))
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            ),

            // Floating action button
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 15,
              right: 17,
              child: KButton(
                icon: Icons.macro_off,
                onTap: () => print("ge"),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 15,
              left: 17,
              child: KButton(
                text: "Open Article",
                icon: Icons.table_restaurant,
                onTap: () => print("ge"),
              ),
            ),
          ],
        ));
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
    required this.widget,
  });

  final DetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 7.0, top: 5),
            child: Text(widget.title,
                style: GoogleFonts.dmSerifText(
                    fontSize: 25, fontWeight: FontWeight.w500)),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            height: 207,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.img!), fit: BoxFit.cover),
                borderRadius: BorderRadius.all(Radius.circular(13)),
                color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 7.0, right: 7),
            child: Column(
              spacing: 3,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.description!,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.workSans(
                        color: Color(0xFF717171),
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                Padding(padding: EdgeInsets.only(top: 10)),
                Text("Source: ${widget.source}",
                    style: GoogleFonts.workSans(
                        fontSize: 13, fontWeight: FontWeight.w500)),
                if (widget.date != null)
                  Text("Last Updated: ${widget.date}",
                      style: GoogleFonts.workSans(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                if (widget.readTime != null)
                  Text("Read Time: ${widget.readTime}",
                      style: GoogleFonts.workSans(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                if (widget.date != null)
                  Text("Last Updated: ${widget.date}",
                      style: GoogleFonts.workSans(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                Padding(padding: EdgeInsets.only(top: 24)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class KButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback onTap;
  const KButton(
      {super.key, required this.icon, this.text = "", required this.onTap});

  @override
  State<KButton> createState() => _KButtonState();
}

class _KButtonState extends State<KButton> {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      color: Colors.white,
      border: Border.all(width: 2, color: Colors.black),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(4, 4), // changes position of shadow
        ),
      ],
    );

    var _child = widget.text == ""
        ? Icon(
            widget.icon,
            color: Colors.black,
          )
        : Row(
            spacing: 8,
            children: [
              Icon(
                widget.icon,
                color: Colors.black,
              ),
              Text("Open Article",
                  style: GoogleFonts.workSans(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500))
            ],
          );

    return GestureDetector(
      onTap: widget.onTap,
      child: widget.text == ""
          ? Container(
              width: 56, height: 56, decoration: boxDecoration, child: _child)
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 13),
              height: 56,
              decoration: boxDecoration,
              child: _child),
    );
  }
}
