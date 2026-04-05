import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  // Variabili private
  Color _background = Colors.black;
  Color _text = Colors.white;
  Color _primary = Colors.blue; // Colore predefinito per bottoni e accenti

  // Getter pubblici per accedere ai colori
  Color get background => _background;
  Color get text => _text;
  Color get primary => _primary;

  /// Aggiorna il tema dell'intera applicazione.
  /// Ora accetta anche il colore [primary] per coerenza grafica.
  void setTheme(Color background, Color text, Color primary) {
    _background = background;
    _text = text;
    _primary = primary;
    
    // Notifica tutti i widget in ascolto (come MaterialApp e le pagine) 
    // di ricostruirsi con i nuovi colori.
    notifyListeners();
  }
}