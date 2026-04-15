import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'storage_service.dart';

enum NotificationType {
  info,
  warning,
  success,
  error,
}

class NotificationService {
  static final List<Map<String, dynamic>> _notifications = [];
  static final AudioPlayer _player = AudioPlayer();

  // ------------------------------------------------------------
  // 🔹 AGGIUNGE UNA NOTIFICA INTERNA (campanella)
  // ------------------------------------------------------------
  static Future<void> addInternalNotification({
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
  }) async {
    final notif = {
      "title": title,
      "message": message,
      "type": type.toString(),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    _notifications.add(notif);

    // Salva in locale
    await StorageService.saveNotifications(_notifications);
  }

  // ------------------------------------------------------------
  // 🔹 RESTITUISCE LE NOTIFICHE SALVATE
  // ------------------------------------------------------------
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final saved = await StorageService.loadNotifications();
    _notifications.clear();
    _notifications.addAll(saved);
    return _notifications;
  }

  // ------------------------------------------------------------
  // 🔹 CANCELLA TUTTE LE NOTIFICHE
  // ------------------------------------------------------------
  static Future<void> clearNotifications() async {
    _notifications.clear();
    await StorageService.saveNotifications([]);
  }

  // ------------------------------------------------------------
  // 🔹 SUONO: WING (nuovo messaggio)
  // ------------------------------------------------------------
  static Future<void> playWingSound() async {
    final enabled = await StorageService.getBool("notifyWingSound") ?? false;
    if (!enabled) return;

    await _player.play(AssetSource("sounds/wing.mp3"));
  }

  // ------------------------------------------------------------
  // 🔹 SUONO: WINKWINK (invio completato)
  // ------------------------------------------------------------
  static Future<void> playSendCompleteSound() async {
    final enabled = await StorageService.getBool("notifySendComplete") ?? false;
    if (!enabled) return;

    await _player.play(AssetSource("sounds/winkwink.mp3"));
  }

  // ------------------------------------------------------------
  // 🔹 SUONO: WINKWINK (ricezione completata)
  // ------------------------------------------------------------
  static Future<void> playReceiveCompleteSound() async {
    final enabled =
        await StorageService.getBool("notifyReceiveComplete") ?? false;
    if (!enabled) return;

    await _player.play(AssetSource("sounds/winkwink.mp3"));
  }

  // ------------------------------------------------------------
  // 🔹 NOTIFICA: WinkGallery ha superato 1GB
  // ------------------------------------------------------------
  static Future<void> notifyGalleryFull() async {
    await addInternalNotification(
      title: "WinkGallery piena",
      message:
          "La tua WinkGallery ha superato 1 GB. Aprila per eliminare i file indesiderati.",
      type: NotificationType.warning,
    );
  }
}
