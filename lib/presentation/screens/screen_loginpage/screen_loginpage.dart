import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/bloc/fetch_division_bloc/fetch_division_bloc.dart';
import 'package:gyandarshan/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:gyandarshan/presentation/screens/screen_homepage/screenhomepage.dart';
import 'package:gyandarshan/widgets/custom_dropdown.dart';
import 'package:gyandarshan/widgets/custom_loginbutton.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';
import 'package:gyandarshan/widgets/custom_textfield.dart';
import 'package:gyandarshan/widgets/customsnackbar.dart';

class ScreenLoginpage extends StatefulWidget {
  const ScreenLoginpage({super.key});

  @override
  State<ScreenLoginpage> createState() => _ScreenLoginpageState();
}

class _ScreenLoginpageState extends State<ScreenLoginpage> {
  final TextEditingController keyController = TextEditingController();
  DropdownItem? selectedDivision;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchDivisionBloc>().add(FetchdivisionInitialEvent());
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
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,

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

                      BlocBuilder<FetchDivisionBloc, FetchDivisionState>(
                        builder: (context, state) {
                          if (state is FetchDivisionLoadingState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8E4F3),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: ResponsiveUtils.screenWidth,
                              padding: EdgeInsets.all(18),
                              child: SpinKitWave(
                                size: 15,
                                color: Appcolors.ksecondarycolor,
                              ),
                            );
                          } else if (state is FetchDivisionSuccessState) {
                            final divisionItems = state.divisions
                                .map(
                                  (division) => DropdownItem(
                                    id: division.divisionId,
                                    display: division.divisionName,
                                  ),
                                )
                                .toList();
                            return CustomDropdown(
                              value: selectedDivision,
                              hintText: 'Please select Division',
                              items: divisionItems,
                              validator: (value) {
                                if (value == null) {
                                  return "Division is required";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedDivision = value;
                                });
                                print('Selected quartersType: $value');
                              },
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      ResponsiveSizedBox.height30,
                      CustomTextField(
                        controller: keyController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Key is required";
                          }

                          return null;
                        },
                        hintText: 'Please Enter Key',
                      ),
                      SizedBox(height: ResponsiveUtils.hp(6)),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            CustomNavigation.pushReplaceWithTransition(
                              context,
                              Screenhomepage(),
                            );
                          } else if (state is LoginErrorState) {
                            CustomSnackbar.show(
                              context,
                              message: state.message,
                              type: SnackbarType.error,
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoadingState) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed:(){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolors.ktextcolor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  elevation: 0,
                                ),
                                child:SpinKitWave(size: 20,color:Appcolors.kwhitecolor,),
                              ),
                            );
                          }
                          return Customloginbutton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                  LoginbuttonClickevent(
                                    divisionId: selectedDivision!.id,
                                    loginKey: keyController.text,
                                  ),
                                );
                              }
                              // CustomNavigation.pushWithTransition(
                              //   context,
                              //   Screenhomepage(),
                              // );
                            },
                            text: 'Sign up',
                          );
                        },
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
      ),
    );
  }
}
