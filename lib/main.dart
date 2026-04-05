import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:media_kit/media_kit.dart';

import 'app.dart';
import 'providers/color_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 NECESSARIO PER USARE media_kit
  MediaKit.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ColorProvider(),
      child: const WinkWinkApp(),
    ),
  );
}
