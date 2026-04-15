import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:winkwink/config/app_config.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../routes.dart';
import '../widgets/neon_button.dart';

class PasswordResetNewPasswordPage extends StatefulWidget {
  const PasswordResetNewPasswordPage({super.key});

  @override
  State<PasswordResetNewPasswordPage> createState() =>
      _PasswordResetNewPasswordPageState();
}

class _PasswordResetNewPasswordPageState
    extends State<PasswordResetNewPasswordPage> {
  final passController = TextEditingController();
  final confirmController = TextEditingController();
  bool loading = false;
  String? error;

  Future<void> saveNewPassword(String email) async {
    setState(() {
      loading = true;
      error = null;
    });

    if (passController.text.trim() != confirmController.text.trim()) {
      setState(() {
        error = "Le password non coincidono";
        loading = false;
      });
      return;
    }

    try {
      final res = await http.post(
        Uri.parse("${AppConfig.baseUrl}/password-reset/new-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": passController.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode != 200) {
        setState(() => error = data["error"] ?? "Errore");
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
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
          "Nuova password",
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
              "Inserisci la nuova password",
              style: TextStyle(
                color: theme.text,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            // 🔥 Campo password rettangolare
            TextField(
              controller: passController,
              obscureText: true,
              style: TextStyle(color: theme.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.30),
                labelText: "Nuova password",
                labelStyle: TextStyle(color: theme.text.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔥 Conferma password rettangolare
            TextField(
              controller: confirmController,
              obscureText: true,
              style: TextStyle(color: theme.text),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.30),
                labelText: "Conferma password",
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
                label: loading ? "..." : "Salva password",
                onPressed: loading ? null : () => saveNewPassword(email),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
