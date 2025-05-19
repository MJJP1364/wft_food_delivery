import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:device_preview/device_preview.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:wft_food_delivery_code/Core/dependency/all_dependency.dart';
import 'package:wft_food_delivery_code/pages/auth_page/auth_view.dart';
import 'package:wft_food_delivery_code/routh.dart';

/// Main entry point for the app.
///
/// Initializes the Supabase client with the given URL and anonymous key,
/// sets the system UI overlay style to have a transparent status bar and
/// dark status bar icons, and runs the app widget.
///
/// The Supabase client is initialized with the following configuration:
///
/// * `url`: The URL of the Supabase instance.
/// * `anonKey`: The anonymous key used to authenticate with the Supabase
///   instance.
///
/// The system UI overlay style is set to have a transparent status bar and
/// dark status bar icons.
///
/// The app widget is then run with the given configuration.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wuqoolyxayfovbkgnvxq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind1cW9vbHl4YXlmb3Zia2dudnhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU3NzE4MTAsImV4cCI6MjA2MTM0NzgxMH0.TKL-JGQVxR-F3sHBpG5Vjtwq-Jr17EoPrZsiM4lA1dc',
  );
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );
 

  // runApp(
  //   DevicePreview(
  //     enabled: true, // Set to true to enable Device Preview
  //     builder: (context) => const MyApp(),
  //   ),

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      getPages: routes,
      initialBinding: AllBinding(),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthPage(),
    );
  }
}
