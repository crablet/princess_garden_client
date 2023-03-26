import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:princess_garden_client/model/v1/last_messages_model.dart';
import 'package:princess_garden_client/model/v1/remaining_lifespan_model.dart';
import 'package:princess_garden_client/model/v1/submit_message_model.dart';

class HttpUtils {
  static String get _hostname => "api.princesssgarden.pink";

  static String get _apiVersion => "v1";

  static Future<http.Response> get(String path,
      [Map<String, dynamic> queryParameters = const {}]) async {
    try {
      final uri = Uri.https(_hostname, "$_apiVersion/$path", queryParameters);
      return await http.get(uri);
    } catch (e) {
      debugPrint('[get] e = $e');
    }

    return http.Response("", 500);
  }

  static Future<http.Response> post(String path,
      [Map<String, dynamic> queryParameters = const {}]) async {
    try {
      final uri = Uri.https(_hostname, "$_apiVersion/$path");
      return await http.post(uri, body: json.encode(queryParameters));
    } catch (e) {
      debugPrint('[post] e = $e');
    }

    return http.Response("", 500);
  }

  static Future<RemainingLifespanModel?> getRemainingLifespan() async {
    final response = await get("remainingLifespan");
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final json = jsonDecode(response.body);
      final remainingLifespan = RemainingLifespanModel.fromJson(json);
      return remainingLifespan;
    }

    return null;
  }

  static Future<SubmitMessageModel?> submitMessage(
      String? author, String content) async {
    final response =
        await post("submitMessage", {"author": author, "content": content});
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final json = jsonDecode(response.body);
      final submitMessage = SubmitMessageModel.fromJson(json);
      return submitMessage;
    }

    return null;
  }

  static Future<LastMessagesModel?> getLastMessages(int count) async {
    final response = await get("lastMessages", {"count": count.toString()});
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final json = jsonDecode(response.body);
      final lastMessage = LastMessagesModel.fromJson(json);
      return lastMessage;
    }

    return null;
  }
}
