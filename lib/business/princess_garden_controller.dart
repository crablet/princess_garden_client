import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:princess_garden_client/base/http_utils.dart';
import 'package:princess_garden_client/model/v1/last_messages_model.dart';

class PrincessGardenController extends GetxController {
  final remainingLifespan = 0.obs;
  final lastMessages = <MessageModel>[].obs;
  late Timer _timer;

  Future<void> fetchRemainingLifespan() async {
    final result = await HttpUtils.getRemainingLifespan();
    if (result != null) {
      remainingLifespan.value = result.data!;
    }
  }

  Future<void> fetchLastMessages(int count) async {
    final result = await HttpUtils.getLastMessages(count);
    if (result != null) {
      lastMessages.addAll(result.data!);
    }
  }

  Future<void> fetchAll() async {
    await fetchRemainingLifespan();
    await fetchLastMessages(53);
  }

  Future<void> submitMessage(String? author, String content) async {
    final result = await HttpUtils.submitMessage(author, content);
    if (result != null) {
      debugPrint("[submitMessage] success, ${result.data}");
    } else {
      debugPrint(
          "[submitMessage] failed, code = ${result?.code}, message = ${result?.message}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAll();
    start();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }

  void start() {
    _timer = Timer.periodic(
      const Duration(seconds: 53),
      (_) => fetchAll(),
    );
  }

  void stop() {
    _timer.cancel();
  }
}
