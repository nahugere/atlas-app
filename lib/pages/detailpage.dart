import 'dart:ui';

import 'package:atlas/services/webService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  builder: (context, snapshot) {
                    // TODO: Error Handling
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MainBodyFlicker(
                        widget: widget,
                        description: widget.description,
                      );
                    } else if (snapshot.hasError == false &&
                        snapshot.connectionState == ConnectionState.done) {
                      Map? data = snapshot.data;
                      return ListView(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          MainBody(
                            widget: widget,
                            description: widget.description ??
                                data?["detail"]["description"],
                          ),
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
                                for (var i in data?["articles"])
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14.0,
                                              bottom: 18.0,
                                              left: 25),
                                          child: Text(i["name"],
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
                                            for (var j in i["articles"])
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      CupertinoPageRoute(
                                                          builder: (builder) {
                                                    return DetailPage(
                                                      title: j["title"],
                                                      category: j["category"],
                                                      img: j["img"] == null
                                                          ? ""
                                                          : j["img"],
                                                      url: j["url"],
                                                      source: j["source"],
                                                      date: j["date"],
                                                      wikiDetail: j["source"] ==
                                                              "Wikipedia"
                                                          ? j["id"].toString()
                                                          : "",
                                                      readTime: j["readTime"] ==
                                                              null
                                                          ? null
                                                          : "${j["readTime"].toStringAsFixed(0)} Min",
                                                      description:
                                                          j["description"] ==
                                                                  null
                                                              ? null
                                                              : j["description"],
                                                    );
                                                  }));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10),
                                                  width: 170,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        height: 200,
                                                        width: 170,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image:
                                                                    NetworkImage(j[
                                                                        "img"]),
                                                                fit: BoxFit
                                                                    .cover),
                                                            color: Color(
                                                                0xFF9D9D9D),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            13))),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 7.0),
                                                        child: Text(j["title"],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .dmSerifText(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                      ),
                                                      Text(j["source"],
                                                          style: GoogleFonts
                                                              .workSans(
                                                                  color: Color(
                                                                      0xFF717171),
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            Container(
                                              width: 10,
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Container(
                      child: Text("Error"),
                    );
                  }),
            ),

            // Floating action button
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: AlignmentGeometry.topCenter,
                          end: AlignmentGeometry.bottomCenter,
                          colors: [
                        const Color.fromARGB(0, 0, 0, 0),
                        const Color.fromARGB(130, 0, 0, 0)
                      ])),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(
                      height: 50,
                      color: const Color.fromARGB(0, 0, 0, 0),
                    ),
                  ),
                )),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 15,
              right: 17,
              child: KButton(
                icon: Icon(
                  Icons.macro_off,
                  color: Colors.black,
                ),
                onTap: () => print("ge"),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 15,
              left: 17,
              child: KButton(
                text: "Open Article",
                icon: SvgPicture.asset(
                  'images/external_link_icon.svg',
                ),
                onTap: () => launchUrl(Uri.parse(widget.url)),
              ),
            ),
          ],
        ));
  }
}

class MainBodyFlicker extends StatelessWidget {
  final String? description;
  final DetailPage widget;
  const MainBodyFlicker({
    super.key,
    this.description,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        MainBody(
          widget: widget,
          description: widget.description,
        ),
        Container(
          width: double.infinity,
          height: 470,
          decoration: BoxDecoration(
              color: Color(0xFFE4E4E4),
              border: Border(top: BorderSide(color: Colors.black, width: 2))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 14.0, bottom: 18.0, left: 25),
                child: Shimmer(
                  color: Colors.grey.shade600,
                  child: Container(
                    width: 200,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 25,
                  ),
                  for (var i = 0; i <= 3; i++)
                    Container(
                      margin: EdgeInsets.only(right: 9),
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 170,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Shimmer(
                              color: Colors.grey.shade600,
                              child: Container(
                                height: 17,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, left: 5.0),
                            child: Shimmer(
                              color: Colors.grey.shade600,
                              child: Container(
                                height: 17,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ),
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
  }
}

class MainBody extends StatelessWidget {
  final String? description;
  const MainBody({
    super.key,
    this.description,
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
                if (description != null)
                  Text(description!,
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
                  Text("Date: ${widget.date}",
                      style: GoogleFonts.workSans(
                          fontSize: 13, fontWeight: FontWeight.w500)),
                if (widget.readTime != null)
                  Text("Read Time: ${widget.readTime}",
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
  final Widget icon;
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
        ? widget.icon
        : Row(
            spacing: 8,
            children: [
              widget.icon,
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
