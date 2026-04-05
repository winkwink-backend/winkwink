import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  XFile? visibleImage;
  XFile? hiddenImage;
  List<Map<String, dynamic>> selectedContacts = [];
  bool isEncrypted = false;
  String? encryptedFilePath;

  Future<void> pickVisibleImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        visibleImage = img;
        hiddenImage = null;
        isEncrypted = false;
      });
    }
  }

  Future<void> openContactsWW() async {
    final result = await Navigator.pushNamed(
      context,
      "/contacts",
      arguments: {"selectionMode": true},
    );

    if (result != null && result is List) {
      setState(() {
        selectedContacts = List<Map<String, dynamic>>.from(result);
        isEncrypted = false;
      });
    }
  }

  Future<void> pickHiddenImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);

    if (img != null) {
      setState(() {
        hiddenImage = img;
        isEncrypted = false;
      });
    }
  }

  Future<void> encryptAndSave() async {
    // TODO: steganografia + criptazione reale
    encryptedFilePath = visibleImage!.path; // placeholder

    setState(() {
      isEncrypted = true;
    });
  }

  Future<void> shareEncrypted() async {
    if (encryptedFilePath == null) return;
    await Share.shareXFiles([XFile(encryptedFilePath!)]);
  }

  @override
  Widget build(BuildContext context) {
    final hasVisibleImage = visibleImage != null;
    final hasContacts = selectedContacts.isNotEmpty;
    final hasHiddenImage = hiddenImage != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Cripta File")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Seleziona immagine visibile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: pickVisibleImage,
              child: const Text("Scegli immagine visibile"),
            ),

            const SizedBox(height: 12),

            // 🔥 BLOCCO IMMAGINI — PERFETTO E SENZA SPAZI NERI
            if (hasVisibleImage && !hasHiddenImage) ...[
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(visibleImage!.path),
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ],

            if (hasVisibleImage && hasHiddenImage) ...[
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(visibleImage!.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(hiddenImage!.path),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            if (hasVisibleImage) ...[
              ElevatedButton(
                onPressed: openContactsWW,
                child: const Text("Contatti WW"),
              ),

              if (hasContacts) ...[
                const SizedBox(height: 12),
                const Text(
                  "Contatti selezionati:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                for (final c in selectedContacts)
                  Text("- ${c["name"]}"),
              ],
            ],

            const SizedBox(height: 24),

            if (hasVisibleImage && hasContacts) ...[
              const Text(
                "Scegli cosa vuoi nascondere:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              if (!hasHiddenImage)
                ElevatedButton(
                  onPressed: pickHiddenImage,
                  child: const Text("Nascondi immagine"),
                ),

              const SizedBox(height: 24),

              if (hasHiddenImage && !isEncrypted)
                Center(
                  child: ElevatedButton(
                    onPressed: encryptAndSave,
                    child: const Text("Cripta (PNG)"),
                  ),
                ),

              if (isEncrypted)
                Center(
                  child: ElevatedButton(
                    onPressed: shareEncrypted,
                    child: const Text("Inoltra"),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}