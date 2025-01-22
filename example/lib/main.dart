import 'package:flutter/material.dart';
import 'package:mobikul_animated_button/mobikul_animated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Mobikul Animated Button"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulBorderButton(
                onPressed: () {},
                text: 'Border Animated Button',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulWaveButton(
                borderRadius: 4,
                onPressed: () {},
                text: 'Wave Button',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulSliderButton(
                onPressed: () {},
                borderRadius: 4,
                text: 'Slider Button',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulAnimatedButton(
                onPressed: () {},
                text: 'Color Slider Button',
                enableColorAnimation: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulAnimatedButton(
                width: 250,
                onPressed: () {},
                text: 'Scale Animation',
                enableColorAnimation: false,
                isReverse: true,
                finalScale: 0.8,
                initialScale: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulAnimatedButton(
                width: 250,
                onPressed: () {},
                text: '',
                isLoading: true,
                isReverse: true,
                finalScale: 0.8,
                initialScale: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MobiKulAnimatedButton(
                width: 250,
                onPressed: () {},
                text: 'Fade Animation',
                fadeStart: 1,
                fadeEnd: 0.5,
                isReverse: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
