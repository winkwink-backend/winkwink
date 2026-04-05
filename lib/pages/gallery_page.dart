import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n/app_localizations.dart';

import '../models/encrypted_file.dart';
import '../routes.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Placeholder: nessun file reale
    final List<EncryptedFile> files = [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.galleryTitle),
      ),
      body: files.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.galleryEmptyPlaceholder,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: files.length,
              itemBuilder: (_, i) {
                final EncryptedFile f = files[i];
                return Card(
                  child: ListTile(
                    title: Text('${l10n.fileLabel} ${f.id}'),
                    subtitle: Text('${l10n.fileTypeLabel}: ${f.type}'),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.decrypt);
                    },
                  ),
                );
              },
            ),
    );
  }
}