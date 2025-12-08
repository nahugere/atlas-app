import 'package:atlas/pages/detailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:atlas/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      HeroMode(
        enabled: false,
        child: CupertinoSliverNavigationBar(
          largeTitle: Text(
            "Saved articles",
            style: GoogleFonts.dmSerifText(
                height: 1.2, fontSize: 34, fontWeight: FontWeight.w500),
          ),
          middle: Text(
            "Saved articles",
            style: GoogleFonts.dmSerifText(
                height: 1.2, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          alwaysShowMiddle: false,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ATile(
              onTap: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (context) {
                  // return DetailPage();
                  return Container(
                    width: double.infinity,
                    height: 200,
                    margin: EdgeInsets.only(bottom: 50),
                  );
                }));
              },
              title:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ipsum risus asdad",
              readTime: "August 19, 2025",
              source: "Author $index",
              img:
                  "https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Wikipedia-logo-v2.svg/500px-Wikipedia-logo-v2.svg.png"),
          childCount: 30,
        ),
      ),
    ]);
  }
}
