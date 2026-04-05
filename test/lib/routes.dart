import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/send_qr_page.dart';
import 'pages/encrypt/encrypt_page.dart';
import 'pages/decrypt_page.dart';
import 'pages/gallery_page.dart';
import 'pages/scan_qr_page.dart';
import 'pages/contacts_page.dart';
import 'pages/passepartout_page.dart';
import 'pages/faq_page.dart';          // <— CORRETTO: contiene FaqPage
import 'pages/password_gate.dart';    // <— CORRETTO: nuovo file
import 'pages/startup_page.dart';

class AppRoutes {
  static const String startup = '/startup';
  static const String login = '/login';
  static const String home = '/home';
  static const String sendQr = '/send-qr';
  static const String encrypt = '/encrypt';
  static const String decrypt = '/decrypt';
  static const String gallery = '/gallery';
  static const String scanQr = '/scan-qr';
  static const String contacts = '/contacts';
  static const String passepartout = '/passepartout';
  static const String faq = '/faq';
  static const String passwordGate = '/password-gate';

  static Map<String, WidgetBuilder> routes = {
    startup: (_) => const StartupPage(),
    login: (_) => const LoginPage(),
    home: (_) => const HomePage(),
    sendQr: (_) => const SendQrPage(),
    encrypt: (_) => const EncryptPage(),
    decrypt: (_) => const DecryptPage(),
    gallery: (_) => const GalleryPage(),
    scanQr: (_) => const ScanQrPage(),
    contacts: (_) => const ContactsPage(),
    passepartout: (_) => const PassepartoutPage(),
    faq: (_) => const FaqPage(),
    passwordGate: (_) => const PasswordGatePage(),
  };
}