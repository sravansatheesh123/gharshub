import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/storage_keys.dart';
import '../auth/login_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    return {
      "name": prefs.getString(StorageKeys.name) ?? "",
      "username": prefs.getString(StorageKeys.username) ?? "",
      "role": prefs.getString(StorageKeys.role) ?? "",
      "token": prefs.getString(StorageKeys.token) ?? "",
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Get.offAll(() => LoginPage());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${data["name"]}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Username: ${data["username"]}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Role: ${data["role"]}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                const Text("Token:",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(
                  data["token"] ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
