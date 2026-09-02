import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prize24_app/configs/theme_config.dart';
import 'package:prize24_app/l10n/arb/app_localizations.dart';
import 'package:prize24_app/routing/app_router.dart';
import 'package:prize24_app/utils/riverpod_observer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      // Never retry any provider
      retry: (retryCount, error) => null,
      observers: [
        RiverpodLogger(),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeConfig.lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
