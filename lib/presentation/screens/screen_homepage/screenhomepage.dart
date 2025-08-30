import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/screens/screen_subcategorypage/screen_subcategorypage.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';

class Screenhomepage extends StatelessWidget {
  Screenhomepage({super.key});

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
                          onPressed: () {},
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
                      'PROPONENT OF TECHNOLOGICAL NEOLOGISM FOR\nRUNNING STAFF OF MYS DIVISION.',
                      textAlign: TextAlign.center,
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

          SizedBox(height: ResponsiveUtils.hp(6)),
          _buildDepartmentTitle(),
          Expanded(
            child: AnimationLimiter(
              child: Container(
                color: const Color.fromARGB(255, 246, 244, 244),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
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
                                ScreenSubcategorypage(title: item.title),
                              );
                            },
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
                              child: Stack(
                                children: [
                                  // NEW badge
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
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
                                          bottomLeft: Radius.circular(12),
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
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Icon/Image
                                        Image.asset(
                                          item.assetPath,
                                          width: 50,
                                          height: 50,
                                          color: const Color(0xFF424242),
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Icon(
                                                  item.fallbackIcon,
                                                  size: 50,
                                                  color: const Color(
                                                    0xFF424242,
                                                  ),
                                                );
                                              },
                                        ),
                                        const SizedBox(height: 15),

                                        // Title
                                        Text(
                                          item.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF212121),
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentTitle() {
    return AnimationConfiguration.staggeredList(
      position: 1,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        verticalOffset: 30.0,
        child: FadeInAnimation(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Mysuru Division Electrical Department',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Appcolors.kblackcolor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<GridItem> items = [
    GridItem(
      title: 'STANDING ORDERS',
      assetPath: 'assets/images/standing_orders.png',
      fallbackIcon: Icons.assignment,
    ),
    GridItem(
      title: 'WORKING TIME TABLE',
      assetPath: 'assets/images/time_table.png',
      fallbackIcon: Icons.access_time,
    ),
    GridItem(
      title: 'PREVENTION OF SPAD',
      assetPath: 'assets/images/prevention_spad.png',
      fallbackIcon: Icons.block,
    ),
    GridItem(
      title: 'TROUBLE SHOOTING',
      assetPath: 'assets/images/trouble_shooting.png',
      fallbackIcon: Icons.build,
    ),
    GridItem(
      title: 'SAFETY DRIVES',
      assetPath: 'assets/images/safety_drives.png',
      fallbackIcon: Icons.warning_amber,
    ),
    GridItem(
      title: 'SAFETY CIRCULARS &\nBULLETIN',
      assetPath: 'assets/images/safety_circulars.png',
      fallbackIcon: Icons.announcement,
    ),
  ];
}

class GridItem {
  final String title;
  final String assetPath;
  final IconData fallbackIcon;

  GridItem({
    required this.title,
    required this.assetPath,
    required this.fallbackIcon,
  });
}
