import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../routes.dart';
import '../widgets/neon_button.dart';
import 'package:winkwink/config/app_config.dart';

class PasswordResetVerifyPage extends StatefulWidget {
  const PasswordResetVerifyPage({super.key});

  @override
  State<PasswordResetVerifyPage> createState() =>
      _PasswordResetVerifyPageState();
}

class _PasswordResetVerifyPageState extends State<PasswordResetVerifyPage> {
  final otpController = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> verifyOtp(String email) async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final res = await http.post(
        Uri.parse("${AppConfig.baseUrl}/password-reset/verify"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otpController.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        setState(() => error = data["error"] ?? "Errore");
      } else {
        Navigator.pushNamed(
          context,
          AppRoutes.passwordResetNewPassword,
          arguments: {"email": email},
        );
      }
    } catch (e) {
      setState(() => error = "Errore di connessione");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final email = args["email"];

    return WinkWinkScaffold(
      showColorSelector: false,
      appBar: AppBar(
        title: const Text(
          "Verifica OTP",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              "Inserisci il codice OTP ricevuto via email",
              style: TextStyle(
                color: theme.text,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 Campo OTP rettangolare
            TextField(
              controller: otpController,
              style: TextStyle(color: theme.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.30),
                labelText: "Codice OTP",
                labelStyle: TextStyle(color: theme.text.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            if (error != null) ...[
              const SizedBox(height: 12),
              Text(
                error!,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],

            const SizedBox(height: 32),

            Center(
              child: NeonButton(
                label: loading ? "..." : "Verifica",
                onPressed: loading ? null : () => verifyOtp(email),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
