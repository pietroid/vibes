import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibes/app/view/app_router.dart';
import 'package:vibes/elements/oscillating_builder.dart';
import 'package:vibes/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.onestTextTheme(ThemeData().textTheme).copyWith(
          displayMedium: const TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
          headlineLarge: const TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          headlineMedium: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: const TextStyle(
            fontSize: 12,
            letterSpacing: 0.1,
            color: Color.fromARGB(217, 255, 255, 255),
          ),
        ),
      ),
    );
  }
}
