import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/screens/screen_homepage/screenhomepage.dart';
import 'package:gyandarshan/widgets/custom_dropdown.dart';
import 'package:gyandarshan/widgets/custom_loginbutton.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';
import 'package:gyandarshan/widgets/custom_textfield.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  State<ScreenLoginpage> createState() => _ScreenLoginpageState();
}

class _ScreenLoginpageState extends State<ScreenLoginpage> {
  final TextEditingController keyController = TextEditingController();
  String? selectedDivision;
  final List<String> divisions = [
    'Mysore',
    'Banglore',
    'Hubli',
    'Manglore',
    "Indore",
  ];
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top image
            Container(
              height: ResponsiveUtils.hp(40),
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/20815.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/asdas.png',
                        height: ResponsiveUtils.hp(15),
                        fit: BoxFit.cover,
                      ),
                    ),
                    ResponsiveSizedBox.height10,
                    TextStyles.subheadline(
                      text: 'Gyandarshan',
                      color: Appcolors.kwhitecolor,
                    ),
                  ],
                ),
              ),
            ),

            // Stack to overlap the white container
            Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Appcolors.kwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ResponsiveSizedBox.height50,
                    TextStyles.headline(text: 'Welcome back'),
                    ResponsiveSizedBox.height5,
                    Text("Login to your account"),
                    ResponsiveSizedBox.height50,

                    CustomDropdown(
                      value: selectedDivision,
                      hintText: 'Please select Division',
                      items: divisions,
                      onChanged: (value) {
                        setState(() {
                          selectedDivision = value;
                        });
                        print('Selected quartersType: $value');
                      },
                    ),
                    ResponsiveSizedBox.height30,
                    CustomTextField(
                      controller: keyController,
                      hintText: 'Please Enter Key',
                    ),
                    SizedBox(height: ResponsiveUtils.hp(6)),
                    Customloginbutton(
                      onPressed: () {
                        CustomNavigation.pushWithTransition(
                          context,
                          Screenhomepage(),
                        );
                      },
                      text: 'Sign up',
                    ),
                    SizedBox(height: ResponsiveUtils.hp(7)),
                    TextStyles.caption(
                      text: 'Designed & Developed by Crisant Technologies',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
