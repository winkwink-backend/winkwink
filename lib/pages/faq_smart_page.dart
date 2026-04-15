import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:winkwink/generated/l10n.dart';

import '../providers/color_provider.dart';
import '../widgets/winkwink_scaffold.dart';
import '../routes.dart';

class FaqSmartPage extends StatefulWidget {
  const FaqSmartPage({super.key});

  @override
  State<FaqSmartPage> createState() => _FaqSmartPageState();
}

class _FaqSmartPageState extends State<FaqSmartPage> {
  Map<String, dynamic> faqData = {};
  String query = "";
  Map<String, dynamic>? bestMatch;

  @override
  void initState() {
    super.initState();
    _loadFaq();
  }

  Future<void> _loadFaq() async {
    final jsonString = await rootBundle.loadString("assets/faq/faq_it.json");
    setState(() {
      faqData = json.decode(jsonString);
    });
  }

  void _search(String text) {
    setState(() {
      query = text;
      bestMatch = _findBestMatch(text);
    });
  }

  Map<String, dynamic>? _findBestMatch(String text) {
    if (text.trim().isEmpty) return null;

    final lower = text.toLowerCase();
    double bestScore = 0;
    Map<String, dynamic>? best;

    faqData.forEach((key, item) {
      final keywords = List<String>.from(item["keywords"]);
      double score = 0;

      for (final k in keywords) {
        if (lower.contains(k.toLowerCase())) score += 1;
      }

      if (score > bestScore) {
        bestScore = score;
        best = item;
      }
    });

    return bestScore > 0 ? best : null;
  }

  void _navigate(String action) {
    final route = {
      "encrypt": AppRoutes.encrypt,
      "sendQr": AppRoutes.sendQr,
      "scanQr": AppRoutes.scanQr,
      "contacts": AppRoutes.contacts,
      "videoWW": AppRoutes.videoWW,
      "passwordResetRequest": AppRoutes.passwordResetRequest,
    }[action];

    if (route != null) {
      Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);
    final l10n = S.of(context)!;

    return WinkWinkScaffold(
      showColorSelector: false,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: _search,
              decoration: InputDecoration(
                hintText: l10n.faqSearchHint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: bestMatch == null
                  ? Center(
                      child: Text(
                        l10n.faqNoResults,
                        style: TextStyle(color: theme.text),
                      ),
                    )
                  : ListView(
                      children: [
                        Text(
                          bestMatch!["answer"],
                          style: TextStyle(
                            color: theme.text,
                            fontSize: 18,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        Wrap(
                          spacing: 10,
                          children: [
                            for (final action in bestMatch!["actions"])
                              ElevatedButton(
                                onPressed: () => _navigate(action),
                                child: Text(
                                  {
                                    "encrypt": l10n.goToEncrypt,
                                    "sendQr": l10n.goToSendQr,
                                    "scanQr": l10n.goToScanQr,
                                    "contacts": l10n.goToContacts,
                                    "videoWW": l10n.goToVideoWW,
                                    "passwordResetRequest":
                                        l10n.goToPasswordReset,
                                  }[action]!,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
