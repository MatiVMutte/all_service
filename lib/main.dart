import 'package:all_service/config/constants/environment.dart';
import 'package:all_service/config/router/app_router.dart';
import 'package:all_service/config/theme/app_theme.dart';
import 'package:all_service/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load( fileName: ".env" );

  await Supabase.initialize(
    url: Environment.supabaseUrl,
    anonKey: Environment.supabaseKey
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modoClaro = ref.watch( providerBrightness );

    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme(claro: modoClaro).getTheme(),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
    );
  }
}