import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/firebase_options.dart';
import 'package:habit_hero/models/hero_stats.dart';
import 'package:habit_hero/providers/auth_provider.dart';
import 'package:habit_hero/providers/hero_provider.dart';
import 'package:habit_hero/screens/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/habit.dart';
import 'providers/habit_provider.dart';
import 'screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HeroStatsAdapter());

  runApp(const HabitHeroApp());
}

class HabitHeroApp extends StatelessWidget {
  const HabitHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider()),
        ChangeNotifierProvider(create: (_) => HeroProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider())
      ],
      child: Consumer<AuthProvider>(builder: (context, auth, _){
        return StreamBuilder(stream: auth.userStream, builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const MaterialApp(
              home: Scaffold(body: Center(child: CircularProgressIndicator(),),),
            );
          }

          final user = snapshot.data;
          if(user == null){
            return const MaterialApp(home: LoginScreen(),);
          } else {
            auth.setUser(user);
            return const MaterialApp(home: HomeScreen(),);
          }
        });
      })
    );
  }
}
