import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:winkwink/config/app_config.dart';

import 'package:winkwink/generated/l10n.dart';
import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final TextEditingController questionCtrl = TextEditingController();

  bool loading = false;
  String? answer;

  Future<void> sendQuestion() async {
    final question = questionCtrl.text.trim();
    if (question.isEmpty) return;

    setState(() {
      loading = true;
      answer = null;
    });

    try {
      final res = await http.post(
        Uri.parse("${AppConfig.baseUrl}faq/ask"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question}),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        setState(() => answer = data["answer"]);
      } else {
        setState(() => answer = "Errore: ${data["error"]}");
      }
    } catch (e) {
      setState(() => answer = "Errore di connessione");
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;
    final theme = Provider.of<ColorProvider>(context);

    return WinkWinkScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: Text(l10n.faqTitle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ⭐ CAMPO DI INPUT
            TextField(
              controller: questionCtrl,
              style: TextStyle(color: theme.text),
              decoration: InputDecoration(
                labelText: "Fai una domanda",
                labelStyle: TextStyle(color: theme.text.withOpacity(0.7)),
                filled: true,
                fillColor: Colors.black.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ⭐ BOTTONE INVIA
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.background,
                foregroundColor: theme.text,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: loading ? null : sendQuestion,
              child: Text(
                loading ? "..." : "Invia domanda",
                style: const TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ RISPOSTA
            if (answer != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    answer!,
                    style: TextStyle(
                      color: theme.text,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ),

            // ⭐ FAQ STATICHE
            if (answer == null)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    l10n.faqContent,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
