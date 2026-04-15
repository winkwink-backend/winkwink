import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  // Variabili private
  Color _background = Colors.black;
  Color _text = Colors.white;

  // ✅ Colore corretto (#C15D42)
  Color _primary = const Color(0xFFC15D42);

  // Getter pubblici
  Color get background => _background;
  Color get text => _text;
  Color get primary => _primary;

  Color get currentTextColor => _text;

  /// Aggiorna il tema dell'intera applicazione.
  void setTheme(Color background, Color text, Color primary) {
    _background = background;
    _text = text;
    _primary = primary;

    notifyListeners();
  }
}
