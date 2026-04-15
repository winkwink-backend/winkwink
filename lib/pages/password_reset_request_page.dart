import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:winkwink/config/app_config.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../routes.dart';
import '../widgets/neon_button.dart';

class PasswordResetRequestPage extends StatefulWidget {
  const PasswordResetRequestPage({super.key});

  @override
  State<PasswordResetRequestPage> createState() =>
      _PasswordResetRequestPageState();
}

class _PasswordResetRequestPageState extends State<PasswordResetRequestPage> {
  final emailController = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> sendOtp() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final res = await http.post(
        Uri.parse("${AppConfig.baseUrl}/password-reset/request"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": emailController.text.trim()}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        setState(() => error = data["error"] ?? "Errore");
      } else {
        Navigator.pushNamed(
          context,
          AppRoutes.passwordResetVerify,
          arguments: {"email": emailController.text.trim()},
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

    return WinkWinkScaffold(
      showColorSelector: false,
      appBar: AppBar(
        title: const Text(
          "Recupero password",
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
              "Inserisci la tua email per ricevere il codice OTP",
              style: TextStyle(
                color: theme.text,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 Campo email rettangolare
            TextField(
              controller: emailController,
              style: TextStyle(color: theme.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.30),
                labelText: "Email",
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
                label: loading ? "..." : "Invia codice",
                onPressed: loading ? null : sendOtp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
