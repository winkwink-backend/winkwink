import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../services/ecc_service.dart';
import '../models/user_profile.dart';
import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../routes.dart';
import '../services/storage_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _hasPassword = false;

  final _ecc = ECCService();
  UserProfile? _profile;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    // 1) Genera ID utente
    final id = _ecc.generateUserId();

    // 2) Genera coppia ECC
    final keyPair = await _ecc.generateKeyPair();
    final publicKey = keyPair.publicKey;

    // 3) Genera QR data (ECCService richiede publicKeyECC)
    final qrData = _ecc.generateQrData(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      userId: id,
      publicKeyECC: publicKey,
    );

    // 4) Salva dati persistenti
    await StorageService.saveEmail(_emailCtrl.text.trim());
    await StorageService.saveHasPassword(_hasPassword);
    await StorageService.saveQrData(qrData);

    if (_hasPassword) {
      await StorageService.savePassword(_passwordCtrl.text.trim());
    }

    // 5) Crea profilo locale (UserProfile NON ha publicKeyECC)
    setState(() {
      _profile = UserProfile(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        id: id,
        qrData: qrData,
        password: _hasPassword ? _passwordCtrl.text.trim() : null,
      );
    });

    // 6) Mostra dialogo
    await showInfoDialog(
      context,
      title: l10n.loginIdGeneratedTitle,
      message: l10n.loginIdGeneratedMessage,
    );

    // 7) Navigazione sicura dopo async gap
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                l10n.loginDescription,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _firstNameCtrl,
                decoration: InputDecoration(labelText: l10n.firstNameLabel),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _lastNameCtrl,
                decoration: InputDecoration(labelText: l10n.lastNameLabel),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _phoneCtrl,
                decoration: InputDecoration(labelText: l10n.phoneLabel),
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? l10n.requiredField : null,
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(labelText: l10n.emailLabel),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return l10n.requiredField;
                  if (!v.contains('@') || !v.contains('.')) {
                    return l10n.invalidEmail;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              SwitchListTile(
                title: Text(l10n.optionalPasswordTitle),
                subtitle: Text(l10n.optionalPasswordSubtitle),
                value: _hasPassword,
                onChanged: (val) {
                  setState(() {
                    _hasPassword = val;
                  });
                },
              ),

              if (_hasPassword) ...[
                const SizedBox(height: 8),

                TextFormField(
                  controller: _passwordCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.passwordLabel,
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (!_hasPassword) return null;
                    if (v == null || v.length < 6) {
                      return l10n.passwordTooShort;
                    }
                    final regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$');
                    if (!regex.hasMatch(v)) {
                      return l10n.passwordMustContain;
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _confirmPasswordCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.confirmPasswordLabel,
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (!_hasPassword) return null;
                    if (v != _passwordCtrl.text) {
                      return l10n.passwordsDontMatch;
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 24),

              NeonButton(
                label: l10n.generateIdButton,
                onPressed: _submit,
              ),

              const SizedBox(height: 16),

              if (_profile != null)
                Text(
                  '${l10n.profileCreatedFor}: ${_profile!.firstName} ${_profile!.lastName}\n'
                  'ID: ${_profile!.id}',
                ),
            ],
          ),
        ),
      ),
    );
  }
}