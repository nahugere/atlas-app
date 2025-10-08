import 'package:atlas/pages/detailpage.dart';
import 'package:atlas/services/webService.dart';
import 'package:atlas/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  final WebService _webService = WebService();
  int _cIndex = 0;
  final List<String> _categories = [
    "All",
    "Technology",
    "Business",
    "Politics",
    "Philosophy",
    "History",
    "Sports",
    "Art"
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HeroMode(
          enabled: false,
          child: SliverPersistentHeader(
            delegate: HeaderDelegate(
                minExtent: MediaQuery.of(context).padding.top + 95,
                maxExtent: MediaQuery.of(context).padding.top + 150),
            pinned: true,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ListView(
              padding: EdgeInsets.only(left: 19, top: 5, bottom: 4),
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < _categories.length; i++)
                  ATabBar(
                      selected: i == _cIndex,
                      val: _categories[i],
                      onTap: () {
                        setState(() {
                          _cIndex = i;
                        });
                        // Future.microtask(() {});
                        // WidgetsBinding.instance.addPostFrameCallback((_) {});
                      }),
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: _webService.getFeed(_categories[_cIndex]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverList(
                  key: PageStorageKey("homepageshimmer"),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ATileShimmer();
                  }, childCount: 10));
            } else if (snapshot.hasError) {
              return SliverToBoxAdapter(
                child: Center(child: Text("Error loading feed")),
              );
            } else {
              // Use SliverList directly
              return SliverList(
                key: PageStorageKey("homepage"),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == (snapshot.data!.length - 1)) {
                      return Container(
                        height: 100,
                      );
                    }
                    return ATile(
                      onTap: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) {
                          return DetailPage();
                        }));
                      },
                      title: snapshot.data?[index]["title"],
                      readTime: snapshot.data?[index]["readTime"] == null
                          ? ""
                          : "${snapshot.data?[index]["readTime"].toStringAsFixed(0)} Min read",
                      source: snapshot.data?[index]["source"],
                      img: snapshot.data?[index]["img"] == null
                          ? ""
                          : snapshot.data?[index]["img"],
                    );
                  },
                  childCount: snapshot.data?.length,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  TextEditingController _searchController = TextEditingController();

  HeaderDelegate({required this.minExtent, required this.maxExtent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Container(
      color: CupertinoTheme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 17),
      child: Stack(
        children: [
          // Big content fades out
          Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 1 - progress,
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "August 19, 2025",
                              style: GoogleFonts.workSans(
                                  height: 1.4,
                                  fontSize: 17,
                                  color: Color(0xFF727272)),
                            ),
                            Text(
                              "Discover articles",
                              style: GoogleFonts.dmSerifText(
                                  height: 1.2,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Spacer(),
                        ClipOval(
                          child: Container(
                              width: 35, height: 35, color: Color(0xFFD1D1D1)),
                        ),
                      ],
                    ),
                  ),
                  ASearchBar(
                    controller: _searchController,
                  )
                ],
              ),
            ),
          ),

          // Small nav title fades in
          Opacity(
            opacity: progress,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 4.0 + MediaQuery.of(context).padding.top),
                child: Text(
                  "Discover articles",
                  style: GoogleFonts.dmSerifText(
                      fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


// return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {},
//                   );

//                   (
//                     key: PageStorageKey('homePage'),
//                     delegate: SliverChildBuilderDelegate(
//                       (context, index) {
//                         return ATile(
//                           onTap: () {
//                             Navigator.of(context)
//                                 .push(CupertinoPageRoute(builder: (context) {
//                               return DetailPage();
//                             }));
//                           },
//                           title:
//                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ipsum risus asdad",
//                           datePublished: "August 19, 2025",
//                           author: "Author $index",
//                         );
//                       },
//                       childCount: 30,
//                     ),
//                   );