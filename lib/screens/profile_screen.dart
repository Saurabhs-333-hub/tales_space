// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:tales_space/controllers/authController.dart';
import 'package:tales_space/models/user_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const ProfileScreen({super.key, required this.scrollController});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _showEditProfile = false;
  bool _showGoToTopButton = false;
  double _titleOpacity = 0.0;
  UserModel? _userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserModel();
    _tabController = TabController(length: 3, vsync: this);
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.maxScrollExtent > 0 &&
          widget.scrollController.position.pixels > 0) {
        setState(() {
          _showGoToTopButton = true;
        });
      } else {
        setState(() {
          _showGoToTopButton = false;
        });
      }
      setState(() {
        if (widget.scrollController.position.pixels > 170) {
          _titleOpacity = 1.0;
        } else {
          _titleOpacity = widget.scrollController.position.pixels / 170;
        }
      });
    });
  }

  setUserModel() async {
    _userModel = await ref.read(currentUserProvider.future);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _showGoToTopButton
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                widget.scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
              child: const Icon(IconlyLight.arrow_up_circle),
            )
          : null,
      body: NestedScrollView(
          controller: widget.scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white.withOpacity(_titleOpacity),
                  ),
                ),
                backgroundColor: Colors.black,
                clipBehavior: Clip.antiAlias,
                surfaceTintColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                flexibleSpace: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FlexibleSpaceBar(
                    background: Container(
                      // clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 100,
                            spreadRadius: 10,
                            offset: const Offset(-50, -50),
                          ),
                          BoxShadow(
                            color: Colors.pink.withOpacity(0.2),
                            blurRadius: 100,
                            spreadRadius: 10,
                            offset: const Offset(-50, -50),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(1),
                            blurRadius: 100,
                            spreadRadius: 100,
                            offset: const Offset(0, 300),
                          ),
                        ],
                        // borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.only(
                          top: 70,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        // backgroundColor: Colors.transparent,
                                        radius: 45,
                                        // backgroundImage:
                                        // CachedNetworkImageProvider(
                                        //     "${_userModel?.profileImage}",
                                        //     scale: 1.0,
                                        //     maxWidth: 1000,
                                        //     maxHeight: 1000),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Followers",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "100",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Following",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "100",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${_userModel?.username}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                // width: 100,
                                height: 30,
                                child: _showEditProfile
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: const Text("Edit"),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          // color: Color(0xFF1B30B2),
                                          boxShadow: [
                                            const BoxShadow(
                                                color: Color(0xFF1B30B2),
                                                blurRadius: 7,
                                                spreadRadius: -2,
                                                offset: Offset(0, 0))
                                          ],
                                          border: Border.all(
                                              color: const Color(0xFF1B30B2),
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        child: const Text("Follow"),
                                      ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: const Text("Insights"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showEditProfile = !_showEditProfile;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: const Text("Post"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                expandedHeight: 300,
                pinned: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyLight.setting),
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      tabs: [
                        const Tab(
                          text: "Series",
                        ),
                        const Tab(
                          text: "Minies",
                        ),
                        const Tab(
                          text: "Lives",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: const Center(
            child: Text("Profile"),
          )),
    );
  }
}
