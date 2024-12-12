import 'package:copyify/core/configs/theme/app_theme.dart';
import 'package:copyify/firebase_options.dart';
import 'package:copyify/presentation/modes/bloc/theme_cubit.dart';
import 'package:copyify/presentation/splash/pages/splash.dart';
import 'package:copyify/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // await Supabase.initialize(
  //   url: 'https://gxlfizaklfizkvmsugxl.supabase.co',
  //   anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd4bGZpemFrbGZpemt2bXN1Z3hsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMwNTc5NDIsImV4cCI6MjA0ODYzMzk0Mn0.UPCaROU4GyWRsZfpz4rFlZmLQWsgUEpqT2jMH94GkOo',
  // );

  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state,
              debugShowCheckedModeBanner: false,
              home: const SplashPage()
          );
        }
      ),
    );
  }
}
