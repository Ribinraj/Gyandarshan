// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gyandarshan/presentation/screens/screen_homepage/screenhomepage.dart';
// import 'package:gyandarshan/widgets/custom_navigation.dart';

// class AppColors {
//   static const kprimarycolor = Color.fromARGB(255, 31, 35, 80);
//   static const kbordercolor = Color.fromARGB(255, 38, 227, 66);
//   static const ktextcolor = Color.fromARGB(255, 6, 165, 102);
//   static const ksecondarycolor = Color.fromARGB(255, 106, 177, 62);
// }

// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Set status bar style
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.light,
//       ),
//     );

//     // Initialize animations
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );

//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );

//     // Start animations
//     _startAnimations();

//     // Navigate to next page after delay
//     _navigateToNextPage();
//   }

//   void _startAnimations() {
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _fadeController.forward();
//     });

//     Future.delayed(const Duration(milliseconds: 500), () {
//       _scaleController.forward();
//     });
//   }

//   void _navigateToNextPage() {
//     Future.delayed(const Duration(seconds: 3), () {
//       CustomNavigation.pushWithTransition(context, Screenhomepage());
//     });
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.kprimarycolor,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               AppColors.kprimarycolor,
//               AppColors.kprimarycolor.withOpacity(0.8),
//               AppColors.ksecondarycolor.withOpacity(0.3),
//             ],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo with animations
//               AnimatedBuilder(
//                 animation: _scaleAnimation,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Container(
//                         width: 150,
//                         height: 150,
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(
//                             color: AppColors.kbordercolor.withOpacity(0.3),
//                             width: 2,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: AppColors.kbordercolor.withOpacity(0.2),
//                               blurRadius: 20,
//                               spreadRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Image.asset(
//                           'assets/images/asdas.png', // Update this path to match your logo location
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),

//               const SizedBox(height: 40),

//               // App name or tagline (optional)
//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Text(
//                   'Your App Name', // Replace with your app name
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Text(
//                   'Welcome to the future', // Replace with your tagline
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppColors.ktextcolor,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 60),

//               // Loading indicator
//               FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       AppColors.kbordercolor,
//                     ),
//                     strokeWidth: 3,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyandarshan/presentation/screens/screen_homepage/screenhomepage.dart';
import 'package:gyandarshan/presentation/screens/screen_loginpage/screen_loginpage.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';
import 'package:gyandarshan/widgets/custom_sharedpreferences.dart';

class AppColors {
  static const kprimarycolor = Color.fromARGB(255, 31, 35, 80);
  static const kbordercolor = Color.fromARGB(255, 38, 227, 66);
  static const ktextcolor = Color.fromARGB(255, 6, 165, 102);
  static const ksecondarycolor = Color.fromARGB(255, 106, 177, 62);
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize animations
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _startAnimations();

    // Navigate to next page after delay
    checkUserlogin(context);
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _scaleController.forward();
    });
  }



  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }
  Future<void> checkUserlogin(context) async {
    final String usertoken = await getUserToken();
    if (usertoken.isEmpty) {
      await Future.delayed(const Duration(seconds: 3));
      CustomNavigation.pushReplaceWithTransition(context, ScreenLoginpage());
    } else {
      CustomNavigation.pushReplaceWithTransition(context,Screenhomepage());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with animations
            AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 150,
                      height: 150,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.kbordercolor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/asdas.png', // Update this path to match your logo location
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Gyandarshan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kprimarycolor,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 16),

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Welcome to the Technological Neologism',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.ktextcolor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Loading indicator
            FadeTransition(
              opacity: _fadeAnimation,
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.kbordercolor,
                  ),
                  strokeWidth: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
