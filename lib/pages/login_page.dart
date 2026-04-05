import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../services/storage_service.dart';
import '../widgets/winkwink_scaffold.dart';
import '../routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ⭐ NUOVO: mostra/nascondi password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool isAlphanumeric(String s) {
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    return regex.hasMatch(s);
  }

  Future<void> doLogin() async {
    final l10n = AppLocalizations.of(context)!;

    final name = nameController.text.trim();
    final surname = surnameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.requiredField)),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.passwordsDontMatch)),
      );
      return;
    }

    if (password.length < 6 || !isAlphanumeric(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.passwordTooShort)),
      );
      return;
    }

    await StorageService.saveProfile(
      name: name,
      surname: surname,
      email: email,
      password: password,
    );

    await StorageService.setRegistered(true);
    await StorageService.setHasPassword(true);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              l10n.loginDescription,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            _buildField(
              controller: nameController,
              label: l10n.firstNameLabel,
            ),

            const SizedBox(height: 12),

            _buildField(
              controller: surnameController,
              label: l10n.lastNameLabel,
            ),

            const SizedBox(height: 12),

            _buildField(
              controller: emailController,
              label: l10n.emailLabel,
            ),

            const SizedBox(height: 12),

            // ⭐ PASSWORD CON OCCHIO
            _buildField(
              controller: passwordController,
              label: l10n.passwordLabel,
              obscure: _obscurePassword,
              onToggleVisibility: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),

            const SizedBox(height: 12),

            // ⭐ CONFERMA PASSWORD CON OCCHIO
            _buildField(
              controller: confirmPasswordController,
              label: l10n.confirmPasswordLabel,
              obscure: _obscureConfirmPassword,
              onToggleVisibility: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: doLogin,
                child: Text(
                  l10n.generateIdButton,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.faq);
                },
                child: const Text(
                  "FAQ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    bool obscure = false,
    VoidCallback? onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade700),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),

        // ⭐ AGGIUNTA: icona occhio
        suffixIcon: onToggleVisibility == null
            ? null
            : IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black87,
                ),
                onPressed: onToggleVisibility,
              ),
      ),
    );
  }
}
