import 'package:ai_bot/provider/message_provider.dart';
import 'package:ai_bot/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MessageProvider()),
    ],
    child: const MyApp()
  ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SplashScreen()
    );
  }
}
