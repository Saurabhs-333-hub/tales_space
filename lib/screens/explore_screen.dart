import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:tales_space/screens/top_creators_slider.dart';

import 'audio_series_slider.dart';
import 'minies_slider.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const ExploreScreen({super.key, required this.scrollController});

  @override
  ConsumerState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoModalPopupRoute(
                        // isScrollControlled: false,
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Search"),
                            ),
                            body: Center(
                              child: Text("Search"),
                            ),
                          );
                        },
                      ));
                    },
                    child: Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(150)),
                                  child: Icon(IconlyLight.search),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(150)),
                                    child: Center(
                                        child: Text(
                                            "Search for audio series, minies")),
                                  ),
                                )
                              ],
                            ))),
                  ),
                  expandedHeight: 100,
                  floating: true,
                  snap: true,
                  // pinned: true,
                ),
              ];
            },
            body: ListView(
              controller: widget.scrollController,
              children: [
                // HeroCarouselSlider(),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Genres",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                AudioSeriesSlider(
                  type: 'genre',
                  genres: ["Horror", "Comedy", "Romance", "Sci-fi", "Fantasy"],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Top Creators",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                TopCreatorsSlider(
                  creators: [
                    "J.R.R. Tolkien",
                    "Neil Gaiman",
                    "Ursula K. Le Guin",
                    "Margaret Atwood",
                    "Haruki Murakami"
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text("Most Watched Minies",
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                MiniesSlider(),
                SizedBox(
                  height: 60,
                )
              ],
            )),
      ),
    );
  }
}
