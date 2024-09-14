import 'package:complete_advanced_flutter/presentation/main/home_page.dart';
import 'package:complete_advanced_flutter/presentation/main/notifications_page.dart';
import 'package:complete_advanced_flutter/presentation/main/search_page.dart';
import 'package:complete_advanced_flutter/presentation/main/settings_page.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  final _title = AppStrings.home;
  final _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: pages[_currentIndex],
    );
  }
}
