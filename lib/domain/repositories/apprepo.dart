import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gyandarshan/core/urls.dart';
import 'package:gyandarshan/data/category_model.dart';
import 'package:gyandarshan/data/content_model.dart';
import 'package:gyandarshan/data/division_model.dart';
import 'package:gyandarshan/data/subcategory_model.dart';
import 'package:gyandarshan/widgets/custom_sharedpreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class Apprepo {
  final Dio dio;

  Apprepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              // connectTimeout: const Duration(seconds: 30),
              // receiveTimeout: const Duration(seconds: 30),
              headers: {'Content-Type': 'application/json'},
            ),
          );

  ///////////// Fetch divisions/////////////
  Future<ApiResponse<List<DivisionModel>>> fetchdivisions() async {
    try {
      // final token = await getUserToken();
      Response response = await dio.get(
        Endpoints.fetchdevisions,
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> divisionlist = responseData['data'];
        List<DivisionModel> divisions = divisionlist
            .map((category) => DivisionModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: divisions,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  /////////////login/////////////////////////

  Future<ApiResponse<String>> sendotp({required String divisionId, required String keyId}) async {
    try {
    
    
      Response response = await dio
          .post(Endpoints.login, data: {
    "divisionId": divisionId,
    "divisionKey": keyId
}
             
              );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
    SharedPreferences preferences = await SharedPreferences.getInstance();

        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        return ApiResponse(
          data:null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ///////////// Fetch categories/////////////
  Future<ApiResponse<List<CategoryModel>>> fetchcategories({required String divisionId}) async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchcategory,
         data: {
    "divisionId": divisionId,
  
},
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> categorylist = responseData['data'];
        List<CategoryModel> categories = categorylist
            .map((category) => CategoryModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: categories,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ///////////// Fetch subcategories/////////////
  Future<ApiResponse<List<SubCategoryModel>>> fetchsubcategories({required String divisionId,required String categoryId}) async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchsubcategory,
         data: {
      "categoryId": categoryId,
            "divisionId": divisionId
  
},
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> subcategorylists = responseData['data'];
        List<SubCategoryModel> subcategories = subcategorylists
            .map((category) => SubCategoryModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: subcategories,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }
  ///////////// Fetch subcategories/////////////
  Future<ApiResponse<List<ContentDataModel>>> fetchcontents({required String divisionId,required String categoryId, required String subcategoryId} ) async {
    try {
      final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchcontent,
         data: {
       "subCategoryId": subcategoryId,
            "divisionId": divisionId,
            "categoryId": categoryId
  
},
        options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;
      log('divisoionssssssss${responseData['status']}');
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> contentlists = responseData['data'];
        List<ContentDataModel> contents = contentlists
            .map((category) => ContentDataModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: contents,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

}
