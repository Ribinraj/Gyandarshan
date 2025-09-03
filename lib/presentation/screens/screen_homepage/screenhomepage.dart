import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/bloc/fetch_category_bloc/fetch_category_bloc.dart';
import 'package:gyandarshan/presentation/screens/screen_loginpage/screen_loginpage.dart';
import 'package:gyandarshan/presentation/screens/screen_subcategorypage/screen_subcategorypage.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';
import 'package:gyandarshan/widgets/custom_sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Screenhomepage extends StatefulWidget {
  const Screenhomepage({super.key});

  @override
  State<Screenhomepage> createState() => _ScreenhomepageState();
}

class _ScreenhomepageState extends State<Screenhomepage> {
  String? id;
  String? title;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatafromprefrenc();
  }

  Future<void> getdatafromprefrenc() async {
    final String fetchid = await getdivisionId();
    final String fetchtitle = await gethomeTitle();
    setState(() {
      id = fetchid;
      title = fetchtitle;
    });
    if (id != null) {
      context.read<FetchCategoryBloc>().add(
        FetchCategoryIintialEvent(divisionId: id!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // white icons
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Blue container with train icon and text
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Appcolors.kprimarycolor,

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ResponsiveSizedBox.height5,
                    Row(
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            _showLogoutDialog();
                          },
                          icon: Icon(
                            Icons.logout_outlined,
                            color: Appcolors.kwhitecolor,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/indianrailways.png', // your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.height20,
                    Text(
                      (title ?? "").toUpperCase(),
                      // 'PROPONENT OF TECHNOLOGICAL NEOLOGISM FOR\nRUNNING STAFF OF MYS DIVISION.',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.hp(1.5),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.hp(6)),
                  ],
                ),
              ),

              // Gyandarshan card (overlapping)
              Positioned(
                bottom: -50,
                left: 20,
                right: 20,
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 30.0,
                    child: FadeInAnimation(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Book icon
                            Image.asset(
                              'assets/images/asdas.png',
                              width: 60,
                              height: 60,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.menu_book,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                );
                              },
                            ),
                            ResponsiveSizedBox.width20,
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Gyandarshan',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Enriching Knowledge, Integrating\nTechnology',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,

                                      color: Colors.grey,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveUtils.hp(7)),
          // _buildDepartmentTitle(),
          Expanded(
            child: AnimationLimiter(
              child: Container(
                color: const Color.fromARGB(255, 246, 244, 244),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: RefreshIndicator(
                  color: Appcolors.ksecondarycolor,
                  onRefresh: () async {
                    if (id != null) {
                      context.read<FetchCategoryBloc>().add(
                        FetchCategoryIintialEvent(divisionId: id!),
                      );
                    }
                  },

                  child: BlocBuilder<FetchCategoryBloc, FetchCategoryState>(
                    builder: (context, state) {
                      if (state is FetchCategoryLoadingState) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: 2,
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is FetchCategorySuccessState) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: state.categories.length,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemBuilder: (context, index) {
                            final item = state.categories[index];
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: 2,
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () {
                                      CustomNavigation.pushWithTransition(
                                        context,
                                        ScreenSubcategorypage(
                                          title: item.categoryFullName!,
                                          categoryId: item.categoryId!,
                                          dvisionId: item.divisionId!,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Appcolors.kprimarycolor
                                              .withAlpha(33),
                                          width: .5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.08,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          // NEW badge
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                  255,
                                                  61,
                                                  201,
                                                  154,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomLeft: Radius.circular(
                                                    12,
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'NEW',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Content
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    item.categoryImage!,
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.contain,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Icon(
                                                            Icons
                                                                .image_not_supported_outlined,
                                                            size: 50,
                                                            color: Color(
                                                              0xFF424242,
                                                            ),
                                                          );
                                                        },
                                                  ),

                                                  ResponsiveSizedBox.height15,

                                                  // Title
                                                  Text(
                                                    item.categoryFullName!,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 13,

                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF212121),
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is FetchCategoryErrorState) {
                        return Center(child: Text(state.message));
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.logout, color: Appcolors.kredcolor),
              const SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Appcolors.kblackcolor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Appcolors.kblackcolor.withAlpha(204)),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Appcolors.kblackcolor.withAlpha(179)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.kredcolor,
                foregroundColor: Appcolors.kwhitecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Logout'),
              onPressed: () async {
                try {
                  final prefs = await SharedPreferences.getInstance();

                  // Clear user token
                  await prefs.clear();

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenLoginpage(),
                      ),
                      (Route<dynamic> route) =>
                          false, // remove all previous routes
                    );
                  }
                } catch (e) {
                  print('Error during logout: $e');
                  // Fallback navigation
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenLoginpage(),
                      ),
                      (Route<dynamic> route) =>
                          false, // remove all previous routes
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
