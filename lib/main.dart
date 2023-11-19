import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/themes/pallete_themes.dart';
import 'meta/features/home/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: ComicCreator(),
    ),
  );
}

class ComicCreator extends StatelessWidget {
  const ComicCreator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashtoon - Creator Comic',
      theme: ColorPallete.getAppTheme(context),
      home: HomeScreen(),
    );
  }
}
