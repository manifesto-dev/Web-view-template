import "dart:async";
import "dart:convert";
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_app_template/business_logic/app.localization.dart';
import 'package:web_app_template/business_logic/app_exceptions.dart';
import 'package:web_app_template/business_logic/core.util.dart';
import 'package:web_app_template/business_logic/network_info.dart';
import 'package:web_app_template/constants/app_strings.dart';

class APICaller {
  final NetworkInfo _networkInfo = NetworkInfoImpl(InternetConnectionChecker());

  String url = AppStrings.baseURL;

  setUrl(String uri, bool isV1) {
    if (isV1) {
      url = 'https://api.halajary.ae/v1$uri';
    } else {
      url = AppStrings.baseURL + uri;
    }
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    token = token?.replaceAll("\"", '');
    return token;
  }

  removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token');
  }

  Future<dynamic> getData(
      {Map<String, String>? headers, bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};

      headers["Accept"] = "application/json";
      headers["Accept-Language"] = 'en';
      if (needAuthorization) {
        String? token = await getToken();
        if (token != null) {
          headers = {
            'Authorization': 'Bearer $token',
          };
        }
      }
      try {
        final res = await http
            .get(Uri.parse(url), headers: headers)
            .timeout(const Duration(seconds: 50), onTimeout: () {
          throw RequestTimeOutException(
              "Poor internet or no internet connectivity");
        });
        var dataRes = _returnResponse(res);

        try {} catch (e) {
          debugPrint("Response parse error");
          debugPrint(e.toString());
        }

        return dataRes;
      } on SocketException {
        return const SocketException('');
      }
    } else {
      throw 'No Internet Connection!';
    }
  }

  Future<dynamic> postData(
      {Map? body,
      Map<String, String>? headers,
      bool needAuthorization = false}) async {
    if (await _networkInfo.isConnected) {
      headers ??= {};
      headers["Accept"] = "application/json";
      headers["Content-Type"] = "application/json";
      headers["Accept-Language"] = 'en';
      headers["currency"] = "1";
      if (needAuthorization) {
        String? token = await getToken();
        if (token != null) {
          headers["Authorization"] = "Bearer $token";
        }
      }
      body ??= {};
      try {
        debugPrint("Json: ${json.encode(body)}");
        final res = await http
            .post(Uri.parse(url), headers: headers, body: json.encode(body))
            .timeout(
                const Duration(
                  seconds: 50,
                ), onTimeout: () {
          throw RequestTimeOutException(
              "Poor internet or no internet connectivity");
        });
        var dataRetrieved = _returnResponse(res);
        return dataRetrieved;
      } on SocketException {
        return [];
      }
    } else {
      return 'No Internet Connection!';
    }
  }

  static String parseError(jsonRes) {
    String errorMessage = "";

    if (jsonRes["errors"] != null) {
      (jsonRes["errors"] as Map<String, dynamic>).forEach((key, value) {
        String keyString = key.replaceAll("_", " ").capitalizeFirst();

        errorMessage = "$errorMessage\n\n";

        if (value is List) {
          String errorIntern = "";
          for (var element in value) {
            String errorMsg = "";
            errorMsg = (element as String).replaceAll("[", "");
            errorMsg = (element).replaceAll("]", ".\n");
            errorIntern += errorMsg;
          }
          errorMessage = "$errorMessage$keyString : $errorIntern";
        } else {
          errorMessage += "$keyString : $value";
        }
      });
    }

    if (jsonRes["message"] != null) {
      if (jsonRes["message"] == "main.invalid-credentials") {
        errorMessage = AppLocalizations.translateInstant("incorrect_cred");
      } else {
        if (errorMessage == "") errorMessage = jsonRes["message"];
      }
      if (jsonRes["message"] == "The token has been blacklisted") {
        APICaller().removeToken();
      }
    }

    return errorMessage.isEmpty ? '// Parse Error ' : errorMessage;
  }

  _returnResponse(http.Response response) {
    debugPrint(
        "response.statusCode.toString() ${response.statusCode.toString()}");
    debugPrint("response.body ${response.body}");
    debugPrint("response.request.toString() ${response.request.toString()}");
    switch (response.statusCode) {
      case 201:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 200:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 204:
        return [];
      case 400:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 401:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 403:
        final responseBody = json.decode(response.body);
        return responseBody;
      case 404:
        final responseBody = json.decode(response.body);
        return responseBody;

      case 503:
        break;
      default:
        final responseBody = json.decode(response.body);
        return responseBody;
    }
  }
}
