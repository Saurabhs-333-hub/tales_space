import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'constants.dart';

class HeroCarouselSlider extends ConsumerStatefulWidget {
  const HeroCarouselSlider({super.key});

  @override
  ConsumerState createState() => _HeroCarouselSliderState();
}

class _HeroCarouselSliderState extends ConsumerState<HeroCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: constraints.maxWidth > 500 ? 350 : contextWidth(context, 1),
        // width: 200.0,
        child: CarouselView(
            itemSnapping: true,
            itemExtent: contextWidth(context, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            children: [
              for (int i = 0; i < 5; i++)
                Stack(
                  children: [
                    Card(
                      surfaceTintColor: Colors.grey,
                      child: SizedBox(
                          width: contextWidth(context, 1),
                          height: contextHeight(context, 1)),
                    ),
                    Positioned(
                      bottom: 20,
                      left: contextWidth(context, 3.5),
                      right: contextWidth(context, 3.5),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 2.0),
                              child: Icon(IconlyLight.play),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Text(
                                "Watch Now",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  height: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ]),
      ),
    );
  }
}
