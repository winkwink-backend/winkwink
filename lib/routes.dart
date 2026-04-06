import 'package:flutter/material.dart';

// 👉 PAGINE PRINCIPALI
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/send_qr_page.dart';
import 'pages/encrypt/encrypt_page.dart';
import 'pages/decrypt_page.dart';
import 'pages/gallery_page.dart';
import 'pages/scan_qr_page.dart';
import 'pages/contacts_page.dart';
import 'pages/passepartout_page.dart';
import 'pages/faq_page.dart';
import 'pages/password_gate.dart';
import 'pages/startup_page.dart';

// 👉 CONTATTI PER ENCRYPT
import 'pages/contacts_page_encrypt.dart';

// 👉 PAGINE STEP 3 (CONTENUTI DA NASCONDERE)
import 'pages/encrypt/hide_image_secret_page.dart';
import 'pages/encrypt/text_secret_page.dart';
import 'pages/encrypt/audio_secret_page.dart';
import 'pages/encrypt/video_secret_page.dart';
import 'pages/encrypt/camera_secret_page.dart';

// ⭐ NUOVA PAGINA SANDWICH
import 'pages/encrypt/sandwich_secret_page.dart';

class AppRoutes {
  // 👉 ROTTE PRINCIPALI
  static const String startup = '/startup';
  static const String login = '/login';
  static const String home = '/home';
  static const String sendQr = '/send-qr';
  static const String encrypt = '/encrypt';
  static const String decrypt = '/decrypt';
  static const String gallery = '/gallery';
  static const String scanQr = '/scan-qr';
  static const String contacts = '/contacts';
  static const String contactsEncrypt = '/contacts_encrypt';
  static const String passepartout = '/passepartout';
  static const String faq = '/faq';
  static const String passwordGate = '/password-gate';

  // 👉 ROTTE STEP 3 (CONTENUTI)
  static const String hideImageSecret = '/hide_image_secret';
  static const String textSecret = '/text_secret';
  static const String audioSecret = '/audio_secret';
  static const String videoSecret = '/video_secret';
  static const String cameraSecret = '/camera_secret';

  // ⭐ NUOVA ROTTA SANDWICH
  static const String sandwichSecret = '/sandwich_secret';

  static Map<String, WidgetBuilder> routes = {
    // 👉 PRINCIPALI
    startup: (_) => const StartupPage(),
    login: (_) => const LoginPage(),
    home: (_) => const HomePage(),
    sendQr: (_) => const SendQrPage(),
    encrypt: (_) => const EncryptPage(),
    decrypt: (_) => const DecryptPage(),
    gallery: (_) => const GalleryPage(),
    scanQr: (_) => const ScanQrPage(),
    contacts: (_) => const ContactsPage(),

    // 👉 CONTATTI PER ENCRYPT
    contactsEncrypt: (_) => const ContactsPageEncrypt(),

    passepartout: (_) => const PassepartoutPage(),
    faq: (_) => const FaqPage(),
    passwordGate: (_) => const PasswordGatePage(),

    // 👉 STEP 3 — CONTENUTI
    hideImageSecret: (_) => const HideImageSecretPage(),
    textSecret: (_) => const TextSecretPage(),
    audioSecret: (_) => const AudioSecretPage(),
    videoSecret: (_) => const VideoSecretPage(),
    cameraSecret: (_) => const CameraSecretPage(),

    // ⭐ SANDWICH
    sandwichSecret: (_) => const SandwichSecretPage(),
  };
}
