import 'package:flutter/material.dart';
import 'package:winkwink/pages/startup_page.dart';

// ⭐ PAGINE WINKWINK
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/inbox_page.dart';
import 'pages/send_qr_page.dart';
import 'pages/scan_qr_page.dart';
import 'pages/encrypt/encrypt_page.dart';
import 'pages/decrypt_page.dart';
import 'pages/gallery_page.dart';
import 'pages/contacts_page.dart';
import 'pages/passepartout_page.dart';
import 'pages/faq_page.dart';
import 'pages/faq_smart_page.dart';
import 'pages/videoww/video_ww_page.dart';
import 'pages/contacts_page_encrypt.dart';

// ⭐ PASSWORD RESET
import 'pages/password_gate.dart';
import 'pages/password_reset_request_page.dart';
import 'pages/password_reset_verify_page.dart';
import 'pages/password_reset_new_password_page.dart';

// ⭐ CHAT
import 'pages/chat/chat_list_page.dart';
import 'pages/chat/chat_page.dart';

// ⭐ P2P (NUOVO)
import 'pages/p2p_send_page.dart';
import 'pages/p2p_receive_page.dart';

// ⭐ SETTINGS (AGGIUNTO)
import 'pages/settings_page.dart';

class AppRoutes {
  static const String home = "/home";
  static const String login = "/login";

  static const String settings = "/settings";
  static const String startup = "/startup";

  static const String inbox = "/inbox";
  static const String sendQr = "/sendQr";
  static const String scanQr = "/scanQr";
  static const String encrypt = "/encrypt";
  static const String decrypt = "/decrypt";
  static const String gallery = "/gallery";
  static const String contacts = "/contacts";
  static const String passepartout = "/passepartout";
  static const String faq = "/faq";
  static const String faqSmart = "/faqSmart";
  static const String videoWW = "/videoWW";
  static const String passwordGate = "/passwordGate";

  // ⭐ PASSWORD RESET
  static const String passwordResetRequest = "/passwordResetRequest";
  static const String passwordResetVerify = "/passwordResetVerify";
  static const String passwordResetNewPassword = "/passwordResetNewPassword";

  // ⭐ CHAT
  static const String chatList = "/chatList";
  static const String chat = "/chat";

  // ⭐ P2P (NUOVO)
  static const String p2pSend = "/p2p_send";
  static const String p2pReceive = "/p2p_receive";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.startup:
        return MaterialPageRoute(builder: (_) => const StartupPage());

      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case inbox:
        return MaterialPageRoute(builder: (_) => const InboxPage());

      case sendQr:
        return MaterialPageRoute(builder: (_) => const SendQrPage());

      case scanQr:
        return MaterialPageRoute(builder: (_) => ScanQrPage());

      case passwordGate:
        return MaterialPageRoute(builder: (_) => const PasswordGatePage());

      case encrypt:
        return MaterialPageRoute(builder: (_) => const EncryptPage());

      case decrypt:
        return MaterialPageRoute(builder: (_) => const DecryptPage());

      case gallery:
        return MaterialPageRoute(builder: (_) => const GalleryPage());

      case contacts:
        return MaterialPageRoute(builder: (_) => const ContactsPage());

      case "/contacts_encrypt":
        return MaterialPageRoute(
          builder: (_) => const ContactsPageEncrypt(),
        );

      case passepartout:
        return MaterialPageRoute(builder: (_) => const PassepartoutPage());

      case faq:
        return MaterialPageRoute(builder: (_) => const FaqPage());

      case faqSmart:
        return MaterialPageRoute(builder: (_) => const FaqSmartPage());

      case videoWW:
        return MaterialPageRoute(builder: (_) => const VideoWWPage());

      // ⭐ PASSWORD RESET FLOW
      case passwordResetRequest:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetRequestPage(),
          settings: settings,
        );

      case passwordResetVerify:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetVerifyPage(),
          settings: settings,
        );

      case passwordResetNewPassword:
        return MaterialPageRoute(
          builder: (_) => const PasswordResetNewPasswordPage(),
          settings: settings,
        );

      // ⭐ CHAT LIST
      case chatList:
        return MaterialPageRoute(
          builder: (_) => ChatListPage(
            userId: args is Map ? args["userId"] : null,
          ),
        );

      // ⭐ CHAT PAGE
      case chat:
        return MaterialPageRoute(
          builder: (_) => ChatPage(
            userId: args is Map ? args["userId"] : null,
            otherId: args is Map ? args["otherId"] : null,
            name: args is Map ? args["name"] : null,
          ),
        );

      // ⭐ P2P SEND (NUOVO)
      case p2pSend:
        return MaterialPageRoute(
          builder: (_) => P2PSendPage(
            fromUserId: args is Map ? args["fromUserId"] : null,
            toUserId: args is Map ? args["toUserId"] : null,
            file: args is Map ? args["file"] : null,
          ),
        );

      // ⭐ P2P RECEIVE (NUOVO)
      case p2pReceive:
        return MaterialPageRoute(
          builder: (_) => P2PReceivePage(
            sessionId: args is Map ? args["sessionId"] : null,
            userId: args is Map ? args["userId"] : null,
          ),
        );

      // ⭐ SETTINGS (AGGIUNTO)
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Route non trovata: ${settings.name}"),
            ),
          ),
        );
    }
  }
}
