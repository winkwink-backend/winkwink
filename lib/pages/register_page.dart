import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../services/ecc_service.dart';
import '../models/user_profile.dart';
import '../widgets/neon_button.dart';
import '../widgets/ww_dialogs.dart';
import '../routes.dart';
import '../services/storage_service.dart';
import '../widgets/winkwink_scaffold.dart';
import '../services/api_service.dart';
import '../providers/color_provider.dart';
import '../l10n/legal/legal_localizations.dart';
import 'dart:ui';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  bool _legalAccepted = false;

  String _prefix = "+39"; // fallback

  final _ecc = ECCService();

  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadPrefix();
  }

  // Normalizzazione telefono
  String normalizePhone(String prefix, String number) {
    final clean = number.replaceAll(RegExp(r'[^0-9]'), '');
    final cleanPrefix = prefix.replaceAll(RegExp(r'[^0-9+]'), '');
    return "$cleanPrefix$clean";
  }

  Future<void> _loadPrefix() async {
    try {
      final locale = PlatformDispatcher.instance.locale;
      final iso = locale.countryCode?.toUpperCase();

      if (iso != null) {
        final map = {
          "IT": "+39",
          "FR": "+33",
          "DE": "+49",
          "ES": "+34",
          "US": "+1",
        };

        setState(() => _prefix = map[iso] ?? "+39");
      }
    } catch (_) {}
  }

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

  // 🔥 POPUP LEGALE CON SCROLL OBBLIGATORIO
  Future<bool> _showLegalDialog() async {
    final legal = LegalLocalizations.of(context);

    bool accepted = false;

    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: const Color(0xFF0B0B0F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          legal.get("legal_terms_title"),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              legal.get("legal_terms_text"),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: accepted,
                              onChanged: (v) {
                                setState(() => accepted = v ?? false);
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.pinkAccent,
                            ),
                            Expanded(
                              child: Text(
                                legal.get("legal_checkbox_text"),
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (accepted)
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pinkAccent,
                              ),
                              onPressed: () {
                                Navigator.of(dialogContext, rootNavigator: true)
                                    .pop(true);
                              },
                              child: Text(
                                legal.get("legal_accept_button"),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ) ??
        false;
  }

  Future<void> _submit() async {
    final l10n = S.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    // 🔥 Verifica password
    if (_confirmPasswordCtrl.text.trim() != _passwordCtrl.text.trim()) {
      await showErrorDialog(
        context,
        title: "Errore",
        message: "Le password non coincidono.",
      );
      return;
    }

    if (!_legalAccepted) {
      await showErrorDialog(
        context,
        title: "Attenzione",
        message: l10n.legalMustAccept,
      );
      return;
    }

    final id = _ecc.generateUserId();
    final keyPair = await _ecc.generateKeyPair();
    final publicKey = keyPair.publicKey;

    final normalizedPhone = normalizePhone(_prefix, _phoneCtrl.text.trim());

    final ok = await ApiService.registerUser(
      phone: normalizedPhone,
      publicKey: publicKey,
    );

    if (!ok) {
      await showErrorDialog(
        context,
        title: "Errore server",
        message: "Impossibile registrare l'utente sul server.",
      );
      return;
    }

    final qrData = _ecc.generateQrData(
      firstName: _firstNameCtrl.text.trim(),
      lastName: _lastNameCtrl.text.trim(),
      phone: normalizedPhone,
      userId: id,
      publicKeyECC: publicKey,
    );

    await StorageService.saveProfile(
      name: _firstNameCtrl.text.trim(),
      surname: _lastNameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );

    await StorageService.setHasPassword(true);
    await StorageService.clearQrData();
    await StorageService.saveQrData(qrData);
    await StorageService.saveUserId(int.parse(id));

    setState(() {
      _profile = UserProfile(
        firstName: _firstNameCtrl.text.trim(),
        lastName: _lastNameCtrl.text.trim(),
        phone: normalizedPhone,
        email: _emailCtrl.text.trim(),
        id: id,
        qrData: qrData,
        password: _passwordCtrl.text.trim(),
      );
    });

    await showInfoDialog(
      context,
      title: l10n.loginIdGeneratedTitle,
      message: l10n.loginIdGeneratedMessage,
    );

    if (!mounted) return;

    await StorageService.setLoggedIn(true);
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      appBar: AppBar(
        title: Text(
          l10n.loginDescriptionShort,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
      ),
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 12),
              _rectField(_firstNameCtrl, l10n.firstNameLabel),
              const SizedBox(height: 12),
              _rectField(_lastNameCtrl, l10n.lastNameLabel),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _prefix,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _rectField(
                      _phoneCtrl,
                      l10n.phoneLabel,
                      keyboard: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.requiredField;
                        }
                        if (v.length < 6) return "Numero non valido";
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _rectField(
                _emailCtrl,
                l10n.emailLabel,
                keyboard: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return l10n.requiredField;
                  }
                  if (!v.contains('@') || !v.contains('.')) {
                    return l10n.invalidEmail;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // 🔥 Password
              _rectPassword(
                _passwordCtrl,
                l10n.passwordLabel,
                _obscurePassword,
                () => setState(() => _obscurePassword = !_obscurePassword),
              ),

              const SizedBox(height: 12),

              // 🔥 Conferma password
              _rectPassword(
                _confirmPasswordCtrl,
                l10n.confirmPasswordLabel,
                _obscureConfirm,
                () => setState(() => _obscureConfirm = !_obscureConfirm),
              ),

              const SizedBox(height: 20),

              // 🔥 Pulsante accetta note legali
              ElevatedButton(
                onPressed: () async {
                  final accepted = await _showLegalDialog();
                  if (accepted) {
                    setState(() => _legalAccepted = true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _legalAccepted ? Colors.green : Colors.pinkAccent,
                ),
                child: Text(
                  l10n.legalAcceptButton,
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: NeonButton(
                  label: l10n.generateIdButton,
                  onPressed: _legalAccepted
                      ? _submit
                      : () async {
                          await showErrorDialog(
                            context,
                            title: "Attenzione",
                            message: l10n.legalMustAccept,
                          );
                        },
                ),
              ),

              if (_profile != null) ...[
                const SizedBox(height: 20),
                Text(
                  '${l10n.profileCreatedFor}: ${_profile!.firstName} ${_profile!.lastName}\nID: ${_profile!.id}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _rectField(
    TextEditingController ctrl,
    String label, {
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.30),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator ??
          (v) =>
              (v == null || v.trim().isEmpty) ? S.current.requiredField : null,
    );
  }

  Widget _rectPassword(
    TextEditingController ctrl,
    String label,
    bool obscure,
    VoidCallback toggle,
  ) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.30),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white70,
          ),
          onPressed: toggle,
        ),
      ),
      validator: (v) =>
          (v == null || v.trim().isEmpty) ? S.current.requiredField : null,
    );
  }
}
