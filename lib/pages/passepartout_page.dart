import 'package:flutter/material.dart';
import 'package:winkwink/generated/l10n.dart';

class PassepartoutPage extends StatelessWidget {
  const PassepartoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.passepartoutTitle),
      ),
      body: Center(
        child: Text(
          l10n.passepartoutPlaceholder,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
