import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/presentation/screens/screen_homepage/screenhomepage.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';

class ScreenContentpage extends StatefulWidget {
  final String title;
  const ScreenContentpage({super.key, required this.title});

  @override
  State<ScreenContentpage> createState() => _ScreenSubcategorypageState();
}

class _ScreenSubcategorypageState extends State<ScreenContentpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            CustomNavigation.pop(context);
          },
          icon: Icon(Icons.chevron_left, size: 27),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Appcolors.kwhitecolor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Appcolors.kprimarycolor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Screenhomepage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.home_outlined),
          ),
        ],
        toolbarHeight: 70,
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
  Widget _buildGridItem(GridItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: .3,
          color: const Color.fromARGB(255, 165, 219, 130),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon/Image
            Image.asset(
              item.assetPath,
              width: 50,
              height: 50,
              color: const Color(0xFF424242),
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  item.fallbackIcon,
                  size: 50,
                  color: const Color(0xFF424242),
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
    );
  }
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
