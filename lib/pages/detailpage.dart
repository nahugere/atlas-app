import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          enableBackgroundFilterBlur: false,
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
              child: ListView(
                children: [
                  Center(
                    child: Text("Hello"),
                  )
                ],
              ),
            ),

            // Floating action button
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              right: 17,
              child: FloatingActionButton(
                onPressed: () {
                  print("he");
                },
                child: Icon(CupertinoIcons.alarm),
              ),
            )
          ],
        ));
  }
}
