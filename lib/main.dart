import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halloween Game',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark,
      ),
      home: const HalloweenGame(),
    );
  }
}

class HalloweenGame extends StatefulWidget {
  const HalloweenGame({super.key});

  @override
  State<HalloweenGame> createState() => _HalloweenGameState();
}
class _HalloweenGameState extends State<HalloweenGame> {
  // Audio players for background music and sound effects
  late AudioPlayer _backgroundPlayer;
  late AudioPlayer _effectPlayer;

  // Random positions for spooky items
  Offset _ghostPosition = Offset(100, 100);
  Offset _pumpkinPosition = Offset(200, 150);
  Offset _batPosition = Offset(50, 300);

  @override
  void initState() {
    super.initState();

    // Initialize audio players
    _backgroundPlayer = AudioPlayer();
    _effectPlayer = AudioPlayer();

    // Load and start playing background music in a loop
    _backgroundPlayer.setLoopMode(LoopMode.all);
    _backgroundPlayer.setAsset('assets/sounds/background_music.mp3').then(
          (_) => _backgroundPlayer.play(),
        );

    // Randomize positions every few seconds
    Timer.periodic(const Duration(seconds: 3), (timer) => _randomizePositions());
  }

  @override
  void dispose() {
    // Dispose audio players when not in use
    _backgroundPlayer.dispose();
    _effectPlayer.dispose();
    super.dispose();
  }

