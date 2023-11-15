import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'web_common_response.dart';
import 'web_exceptions.dart';
import 'web_request.dart';

class Webservice {
  static final Webservice _instance = Webservice._internal();

  factory Webservice() => _instance;

  Webservice._internal();

  Map<String, String> postHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> getHeaders = {
    'Content-Type': 'application/json',
    "Accept": "application/json"
  };

  Future<dynamic> postWithAuthAndRequest(String action, dynamic params) async {
    Map mapResponseJson;

    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});
    var requestJson = jsonEncode(params);

    try {
      final response = await http.post(Uri.parse(action),
          headers: postHeaders, body: requestJson);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> getWithAuthAndStringRequest(
      String action, dynamic params) async {
    Map mapResponseJson;
    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});
    var requestJson = jsonEncode(params);

    try {
      final response = await http.get(
        Uri.parse(action + requestJson),
        headers: postHeaders,
      );
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> getWithAuthAndClassRequest(
      String action, dynamic params) async {
    Map mapResponseJson;
    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});

    try {
      final uri = Uri.parse(action).replace(queryParameters: params);
      debugPrint("object-uri $uri");
      final response = await http.get(
        uri,
        headers: postHeaders,
      );
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> getWithOutAuthAndStringRequest(
      String action, dynamic stringParams) async {
    Map mapResponseJson;

    debugPrint("##action### $action");
    debugPrint("##stringParams### $stringParams");
    debugPrint("##action+stringParams### ${action + stringParams}");

    try {
      final uri =
      Uri.parse(action + stringParams);
      final response = await http.get(
        uri,
        headers: postHeaders,
      );
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> getWithOutAuthAndQueryAndStringRequest(
      String action, dynamic params, dynamic stringParams) async {
    Map mapResponseJson;
    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});

    debugPrint("##getWithAuthAndClassQueryRequest###");
    debugPrint("##action### $action");
    debugPrint("##tokenValue### $tokenValue");
    debugPrint("##params### ${jsonEncode(params)}");

    // var requestJson = jsonEncode(stringParams);
    debugPrint("##stringParams### $stringParams");
    debugPrint("##action+stringParams### ${action + stringParams}");

    try {
      final uri =
      Uri.parse(action + stringParams).replace(queryParameters: params);
      final response = await http.get(
        uri,
        headers: postHeaders,
      );
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> postWithoutAuthAndRequest(String action) async {
    Map mapResponseJson;
    postHeaders.removeWhere((key, value) => key == "Authorization");

    try {
      final response = await http.post(Uri.parse(action), headers: postHeaders);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return mapResponseJson;
  }

  Future<dynamic> postWithAuthWithoutRequest(String action) async {
    Map mapResponseJson;
    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});

    try {
      final response = await http.post(Uri.parse(action), headers: postHeaders);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> getWithAuthWithoutRequest(String action) async {
    Map mapResponseJson;

    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});
    debugPrint("##action## $action");
    try {
      final response = await http.get(Uri.parse(action), headers: postHeaders);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> postWithRequestWithoutAuth(
      String action, dynamic param) async {
    Map mapResponseJson = {};
    postHeaders.removeWhere((key, value) => key == "Authorization");

    var requestJson = jsonEncode(param);
    debugPrint("request action $action",wrapWidth: 400);
    debugPrint("requestJson $requestJson",wrapWidth: 400);

    try {
      final response = await http.post(Uri.parse(action),
          headers: postHeaders, body: requestJson);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }

    return mapResponseJson;
  }

  Future<dynamic> postWithAuthAndRequestAndAttachment(
      String action, String filePath) async {
    Map mapResponseJson;
    String tokenValue = await SharedPrefs().getUserToken();
    postHeaders.addAll({'Authorization': "Bearer $tokenValue"});

    var postUri = Uri.parse(action);

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    try {
      request.headers.addAll(postHeaders);
      if (filePath.isNotEmpty) {
        http.MultipartFile multipartFile =
            await http.MultipartFile.fromPath('photo', filePath);
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Future<dynamic> putWithRequestWithoutAuth(
      String action, dynamic param) async {
    Map mapResponseJson = {};
    postHeaders.removeWhere((key, value) => key == "Authorization");

    var requestJson = jsonEncode(param);
    debugPrint("request action $action",wrapWidth: 400);
    debugPrint("requestJson $requestJson",wrapWidth: 400);

    try {
      final response = await http.put(Uri.parse(action),
          headers: postHeaders, body: requestJson);
      mapResponseJson = processResponseToJson(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return mapResponseJson;
  }

  Map processResponseToJson(http.Response response) {
    WebCommonResponse mWebCommonResponse = WebCommonResponse();

    var responseBody = response.body;

    mWebCommonResponse.statusCode = response.statusCode.toString();

    debugPrint("responseBody $responseBody",wrapWidth: 5000);
    debugPrint("statusCode ${mWebCommonResponse.statusCode}");

    switch (response.statusCode) {
      case 200:
        mWebCommonResponse.data = responseBody.isNotEmpty
            ? responseBody.toString()
            : WebConstants.statusCode200Message;
        return mWebCommonResponse.toJson();
      case 400:
        mWebCommonResponse.data = responseBody.toString();
        return mWebCommonResponse.toJson();
      case 401:
        mWebCommonResponse.data = WebConstants.statusCode401Message;
        return mWebCommonResponse.toJson();
      case 403:
        mWebCommonResponse.data = WebConstants.statusCode404Message;
        return mWebCommonResponse.toJson();
      case 404:
        mWebCommonResponse.data = WebConstants.statusCode404Message;
        return mWebCommonResponse.toJson();
      case 412:
        mWebCommonResponse.data = responseBody.isNotEmpty
            ? responseBody.toString()
            : WebConstants.statusCode412Message;
        return mWebCommonResponse.toJson();
      case 422:
        mWebCommonResponse.data = responseBody.isNotEmpty
            ? responseBody.toString()
            : WebConstants.statusCode422Message;
        return mWebCommonResponse.toJson();
      case 500:
        mWebCommonResponse.data = WebConstants.statusCode502Message;
        return mWebCommonResponse.toJson();
      case 502:
        mWebCommonResponse.data = WebConstants.statusCode502Message;
        return mWebCommonResponse.toJson();
      case 503:
        mWebCommonResponse.data = WebConstants.statusCode503Message;
        return mWebCommonResponse.toJson();
      default:
        mWebCommonResponse.data = WebConstants.statusCode503Message;
        return mWebCommonResponse.toJson();
    }
  }
}
