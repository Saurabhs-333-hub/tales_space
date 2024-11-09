import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class TopCreatorsSlider extends ConsumerStatefulWidget {
  String type;
  List<String>? creators;
  TopCreatorsSlider({super.key, this.type = 'creators', this.creators});

  @override
  ConsumerState createState() => _TopCreatorsSliderState();
}

class _TopCreatorsSliderState extends ConsumerState<TopCreatorsSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: 200,
        // width: 200.0,
        child: CarouselView(
            itemSnapping: true,
            itemExtent: 200,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            children: [
              for (int i = 0; i < 5; i++)
                Stack(children: [
                  Card(
                    surfaceTintColor: Colors.grey,
                    child: SizedBox(
                        width: contextWidth(context, 1),
                        height: contextHeight(context, 1)),
                  ),
                  Positioned(
                    bottom: 15,
                    left: 15,
                    right: 15,
                    child: Container(
                      // width: 200,
                      clipBehavior: Clip.antiAlias,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // if (widget.type == 'audio') ...{
                          //   Flexible(
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(right: 2.0),
                          //       child: Text(
                          //         "Listen Now",
                          //         overflow: TextOverflow.ellipsis,
                          //         style: GoogleFonts.poppins(
                          //           fontSize: 16,
                          //           height: 0,
                          //         ),
                          //       ),
                          //     ),
                          //   )
                          // },
                          if (widget.type == 'creators') ...{
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 2.0),
                                child: Text(
                                  widget.creators![i],
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    height: 0,
                                  ),
                                ),
                              ),
                            )
                          }
                        ],
                      ),
                    ),
                  ),
                ])
            ]),
      ),
    );
  }
}
