import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/winkwink_scaffold.dart';
import '../providers/color_provider.dart';
import '../services/wwgallery_service.dart';
import '../services/storage_service.dart';
import 'package:winkwink/generated/l10n.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Map<String, dynamic>> qrFiles = [];
  bool loading = true;

  // FILTRO
  String filter = "all";

  // SELEZIONE MULTIPLA
  bool selectionMode = false;
  Set<String> selectedPaths = {};

  @override
  void initState() {
    super.initState();
    _loadGallery();
  }

  // ------------------------------------------------------------
  // 🔥 CARICA TUTTI I FILE SALVATI
  // ------------------------------------------------------------
  Future<void> _loadGallery() async {
    final files = await WWGalleryService.loadAllQr();
    setState(() {
      qrFiles = files;
      loading = false;
    });
  }

  // ------------------------------------------------------------
  // 🔥 APRE UN QR E AGGIORNA IL CONTATTO
  // ------------------------------------------------------------
  Future<void> _openQr(Map<String, dynamic> item) async {
    final qrData = item["qrData"];
    final parts = qrData.split("|");

    if (parts.length != 6) {
      _showInfo("Errore", "QR non valido");
      return;
    }

    final userId = parts[1];
    final firstName = parts[2];
    final lastName = parts[3];
    final phone = parts[4];
    final publicKey = parts[5];

    final contact = {
      "name": "$firstName $lastName",
      "userId": userId,
      "phone": phone,
      "publicKey": publicKey,
      "qrData": qrData,
    };

    await StorageService.addOrUpdateContact(contact);

    _showInfo(
      "Contatto aggiornato",
      "$firstName $lastName è stato aggiornato correttamente",
    );
  }

  // ------------------------------------------------------------
  // 🔥 ELIMINA UN FILE
  // ------------------------------------------------------------
  Future<void> _deleteSingle(Map<String, dynamic> item) async {
    await WWGalleryService.deleteItem(item["path"]);
    await _loadGallery();
    _showInfo("Eliminato", "Il file è stato rimosso dalla WinkGallery");
  }

  // ------------------------------------------------------------
  // 🔥 ELIMINA MULTIPLI
  // ------------------------------------------------------------
  Future<void> _deleteSelected() async {
    for (final path in selectedPaths) {
      await WWGalleryService.deleteItem(path);
    }
    selectedPaths.clear();
    selectionMode = false;
    await _loadGallery();
  }

  // ------------------------------------------------------------
  // 🔥 DIALOGO RAPIDO
  // ------------------------------------------------------------
  void _showInfo(String title, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ColorProvider>(context);

    // FILTRAGGIO
    final visibleFiles = qrFiles.where((item) {
      if (filter == "all") return true;
      return item["type"] == filter;
    }).toList();

    return WinkWinkScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.4),
        elevation: 0,
        title: const Text("WinkGallery"),
        actions: selectionMode
            ? [
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    if (selectedPaths.isEmpty) return;
                    _deleteSelected();
                  },
                )
              ]
            : [],
      ),
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 🔥 FILTRO
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: DropdownButton<String>(
                    value: filter,
                    dropdownColor: Colors.black,
                    items: const [
                      DropdownMenuItem(
                          value: "all",
                          child: Text("Tutti",
                              style: TextStyle(color: Colors.white))),
                      DropdownMenuItem(
                          value: "qr",
                          child: Text("QR",
                              style: TextStyle(color: Colors.white))),
                      DropdownMenuItem(
                          value: "secret",
                          child: Text("Segreti",
                              style: TextStyle(color: Colors.white))),
                    ],
                    onChanged: (v) {
                      setState(() => filter = v!);
                    },
                  ),
                ),

                Expanded(
                  child: visibleFiles.isEmpty
                      ? const Center(
                          child: Text("Nessun file trovato",
                              style: TextStyle(color: Colors.white)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: visibleFiles.length,
                          itemBuilder: (_, i) {
                            final item = visibleFiles[i];

                            return Card(
                              color: Colors.black.withOpacity(0.4),
                              child: ListTile(
                                onLongPress: () {
                                  setState(() => selectionMode = true);
                                },
                                leading: selectionMode
                                    ? Checkbox(
                                        value: selectedPaths
                                            .contains(item["path"]),
                                        onChanged: (v) {
                                          setState(() {
                                            if (v == true) {
                                              selectedPaths.add(item["path"]);
                                            } else {
                                              selectedPaths
                                                  .remove(item["path"]);
                                            }
                                          });
                                        },
                                      )
                                    : null,
                                title: Text(
                                  item["name"],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  item["phone"],
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                trailing: selectionMode
                                    ? null
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.qr_code,
                                                color: Colors.white),
                                            onPressed: () => _openQr(item),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.redAccent),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text(
                                                      "Eliminare questo file?"),
                                                  content: const Text(
                                                      "L'operazione non può essere annullata."),
                                                  actions: [
                                                    TextButton(
                                                      child:
                                                          const Text("Annulla"),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("Elimina"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _deleteSingle(item);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
