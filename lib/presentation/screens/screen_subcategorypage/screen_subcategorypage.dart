import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gyandarshan/core/colors.dart';
import 'package:gyandarshan/core/constants.dart';
import 'package:gyandarshan/core/responsiveutils.dart';
import 'package:gyandarshan/presentation/bloc/fetch_subcategory_bloc/fetch_subcategory_bloc.dart';
import 'package:gyandarshan/presentation/screens/screen_contentpage/screen_contentpage.dart';
import 'package:gyandarshan/widgets/custom_navigation.dart';
import 'package:shimmer/shimmer.dart';

class ScreenSubcategorypage extends StatefulWidget {
  final String title;
  final String categoryId;
  final String dvisionId;
  const ScreenSubcategorypage({
    super.key,
    required this.title,
    required this.categoryId,
    required this.dvisionId,
  });

  @override
  State<ScreenSubcategorypage> createState() => _ScreenSubcategorypageState();
}

class _ScreenSubcategorypageState extends State<ScreenSubcategorypage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchSubcategoryBloc>().add(
      FetchSubcategoryIntialEvent(
        divisionId: widget.dvisionId,
        categoryId: widget.categoryId,
      ),
    );
  }

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
        toolbarHeight: 70,
      ),
      body: AnimationLimiter(
        child: Container(
          color: const Color.fromARGB(255, 246, 244, 244),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: RefreshIndicator(
            color: Appcolors.ksecondarycolor,
            onRefresh: () async {
              context.read<FetchSubcategoryBloc>().add(
                FetchSubcategoryIntialEvent(
                  divisionId: widget.dvisionId,
                  categoryId: widget.categoryId,
                ),
              );
            },
            child: BlocBuilder<FetchSubcategoryBloc, FetchSubcategoryState>(
              builder: (context, state) {
                if (state is FetchSubcategoryLoadingState) {
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
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FetchSubcategorySuccessState) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: .9,
                        ),
                    itemCount: state.subcategories.length,
                    itemBuilder: (context, index) {
                      final item = state.subcategories[index];
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
                                  ScreenContentpage(
                                    title: item.groupName,
                                    divisionId: item.divisionId,
                                    categoryId: item.categoryId,
                                    subcategoryId: item.subCategoryId,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: .3,
                                    color: Appcolors.kprimarycolor.withAlpha(
                                      33,
                                    ),
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
                                      Image.asset(
                                        'assets/images/6330-removebg-preview.png',
                                        width: ResponsiveUtils.wp(25),
                                        //height: 90,
                                        fit: BoxFit.contain,
                                      ),

                                      ResponsiveSizedBox.height5,

                                      // Title
                                      Text(
                                        item.groupName,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is FetchSubcategoriesErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
