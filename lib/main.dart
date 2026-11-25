import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/portfolio_api.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.api});

  final PortfolioApi? api;

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
    final injected = api;
    if (injected != null) {
      return ChangeNotifierProvider.value(value: injected, child: app);
    }
    return ChangeNotifierProvider(
      create: (_) {
        final service = PortfolioApi();
        unawaited(service.restoreSession());
        return service;
      },
      child: app,
    );
  }
}
