import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/injection_container.dart';
import 'core/routing/app_router.dart';
import 'core/routing/app_routes.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock portrait orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase
  // Uncomment after running `flutterfire configure`:
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Temporary: Initialize Firebase without options for structure validation
  // Remove the try/catch block once firebase_options.dart is configured
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase not yet configured — run `flutterfire configure`
    debugPrint('⚠️  Firebase not configured yet. Run: flutterfire configure');
  }

  // Setup GetIt dependency injection
  await setupDependencies();

  // 🔴 سيتم إنشاء الحسابات التجريبية عند تشغيل التطبيق.
  // (يفضل حذف هذا السطر أو تعليقه بعد التشغيل الأول لتسريع التطبيق)
  //await MockSeeder.seedUsers();

  runApp(const AtharApp());
}

class AtharApp extends StatelessWidget {
  const AtharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أثر',
      debugShowCheckedModeBanner: false,

      // ── Theme ──────────────────────────────────────────────────────────
      theme: AppTheme.lightTheme,

      // ── Routing ────────────────────────────────────────────────────────
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,

      // ── Arabic Localization & RTL ───────────────────────────────────────
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [Locale('ar', 'SA'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
    );
  }
}
