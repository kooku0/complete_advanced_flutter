import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Main View',
        style: TextStyle(color: ColorManager.white),
      ),
    );
  }
}
