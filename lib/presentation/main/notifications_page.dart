import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        AppStrings.notifications,
        style: TextStyle(color: Colors.black),
      ).tr(),
    );
  }
}
