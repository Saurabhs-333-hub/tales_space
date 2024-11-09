import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'books_slider.dart';

class BooksScreen extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const BooksScreen({super.key, required this.scrollController});

  @override
  ConsumerState createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue, Colors.pink],
                        ).createShader(bounds),
                    child: FittedBox(
                        child: const Text('Read Something...',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 30)))),
                floating: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(IconlyLight.buy),
                  )
                ],
              ),
            ];
          },
          body: ListView(
            controller: widget.scrollController,
            children: [
              // const HeroCarouselSlider(),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Novels",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              BooksSlider(
                editors: [
                  'Leo Tolstoy',
                  'Fyodor Dostoevsky',
                  'Jane Austen',
                  'William Shakespeare',
                  'Gabriel García Márquez'
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Stories",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              BooksSlider(
                editors: [
                  'Edgar Allan Poe',
                  'Mark Twain',
                  'Virginia Woolf',
                  'Ernest Hemingway',
                  'Toni Morrison'
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Poetry",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              BooksSlider(
                editors: [
                  'William Wordsworth',
                  'Emily Dickinson',
                  'John Keats',
                  'Pablo Neruda',
                  'Rumi'
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Biographies",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              BooksSlider(
                editors: [
                  'Benjamin Franklin',
                  'Nelson Mandela',
                  'Steve Jobs',
                  'Malala Yousafzai',
                  'Michelle Obama'
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text("Religious",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              BooksSlider(
                editors: [
                  'The Bible',
                  'The Quran',
                  'The Bhagavad Gita',
                  'The Torah',
                  'The Guru Granth Sahib'
                ],
              ),
              const SizedBox(
                height: 60,
              )
            ],
          )),
    );
  }
}
