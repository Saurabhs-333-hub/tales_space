import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:tales_space/screens/profile_screen.dart';

import 'books_screen.dart';
import 'constants.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'minies_screen.dart';

class MainWrapper extends ConsumerStatefulWidget {
  const MainWrapper({super.key});

  @override
  ConsumerState<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  PageController? _pageController;
  int _currentPageIndex = 0;
  List<ScrollController>? _scrollControllers;
  double bottomPosition = 16;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _pageController!.addListener(() {
      setState(() {
        _currentPageIndex = _pageController!.page!.round();
      });
    });
    setState(() {
      _scrollControllers = List.generate(getScreens().length, (index) {
        return ScrollController();
      });
      for (int i = 0; i < _scrollControllers!.length; i++) {
        _scrollControllers![i].addListener(() {
          if (_scrollControllers![i].position.userScrollDirection ==
              ScrollDirection.reverse) {
            setState(() {
              ref.read(bottomPositionProvider.notifier).state = -100;
            });
          } else {
            setState(() {
              ref.read(bottomPositionProvider.notifier).state = 16;
            });
          }
        });
      }
    });
  }

  List<Widget> getScreens({List<ScrollController>? controllers}) {
    List<Widget> _screens = [
      controllers?[0] != null
          ? HomeScreen(
              scrollController: controllers![0],
              onScroll: () {
                // log('Scroll event on HomeScreen');
              },
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      controllers?[1] != null
          ? ExploreScreen(
              scrollController: controllers![1],
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      controllers?[2] != null
          ? BooksScreen(
              scrollController: controllers![2],
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      controllers?[3] != null
          ? MiniesScreen(
              scrollController: controllers![3],
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      controllers?[4] != null
          ? ProfileScreen(
              scrollController: controllers![4],
            )
          : Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    ];
    return _screens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return getScreens(controllers: _scrollControllers)[index];
            },
            itemCount: getScreens().length,
          ),
          AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              bottom: ref.watch(bottomPositionProvider),
              left: 30,
              right: 30,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(150),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BottomBarButton(
                        icon: IconlyLight.home,
                        onTapCallback: () {
                          _pageController!.jumpToPage(0);
                        },
                        isSelected: _currentPageIndex == 0,
                        label: 'Home',
                        color: Colors.deepPurple.shade100),
                    BottomBarButton(
                        icon: IconlyLight.search,
                        onTapCallback: () {
                          _pageController!.jumpToPage(1);
                        },
                        isSelected: _currentPageIndex == 1,
                        label: 'Explore',
                        color: Colors.deepPurple.shade100),
                    BottomBarButton(
                        icon: IconlyLight.paper,
                        onTapCallback: () {
                          _pageController!.jumpToPage(2);
                        },
                        isSelected: _currentPageIndex == 2,
                        label: 'Books',
                        color: Colors.deepPurple.shade100),
                    BottomBarButton(
                        icon: IconlyLight.play,
                        onTapCallback: () {
                          _pageController!.jumpToPage(3);
                        },
                        isSelected: _currentPageIndex == 3,
                        label: 'Minies',
                        color: Colors.deepPurple.shade100),
                    BottomBarButton(
                        icon: IconlyLight.profile,
                        onTapCallback: () {
                          _pageController!.jumpToPage(4);
                        },
                        isSelected: _currentPageIndex == 4,
                        label: 'You',
                        color: Colors.deepPurple.shade100),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BottomBarButton extends StatelessWidget {
  IconData icon;
  final Function() onTapCallback;
  final bool isSelected;
  final String label;
  final Color color;
  BottomBarButton(
      {super.key,
      required this.icon,
      required this.onTapCallback,
      required this.isSelected,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onTapCallback,
        color: isSelected ? color : Colors.grey,
      ),
    );
  }
}
