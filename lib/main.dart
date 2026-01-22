import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gharshub/core/storage_keys.dart';
import 'package:gharshub/screen/auth/login_page.dart';
import 'package:gharshub/screen/auth/reset_password_page.dart';
import 'package:gharshub/screen/dashboard/dashboard_page.dart';

import 'bindings/dashboard_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  bool _checkingSession = true;
  Widget _startPage = const _LoadingPage();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
    _listenDeepLinks();
  }

  Future<void> _checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(StorageKeys.token) ?? "";
    final loginTime = prefs.getInt(StorageKeys.loginTime) ?? 0;

    final now = DateTime.now().millisecondsSinceEpoch;
    const threeDaysMs = 3 * 24 * 60 * 60 * 1000;

    if (token.isNotEmpty &&
        loginTime != 0 &&
        (now - loginTime) <= threeDaysMs) {

      _startPage = Builder(
        builder: (context) {
          DashboardBinding().dependencies();
          return DashboardPage();
        },
      );

    } else {
      await prefs.clear();
      _startPage = LoginPage();
    }


    setState(() {
      _checkingSession = false;
    });
  }

  Future<void> _listenDeepLinks() async {
    final Uri? initialUri = await _appLinks.getInitialLink();
    _handleUri(initialUri);

    _appLinks.uriLinkStream.listen((Uri uri) {
      _handleUri(uri);
    });
  }

  void _handleUri(Uri? uri) {
    if (uri == null) return;

    if (uri.host == "admin.gharshub.com" &&
        uri.path.contains("reset-password")) {
      final token = uri.queryParameters["token"];

      if (token != null && token.isNotEmpty) {
        Get.to(() => ResetPasswordPage(token: token));
      } else {
        Get.snackbar("Error", "Token not found in reset link");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gharshub',
      theme: ThemeData(useMaterial3: true),
      initialBinding: DashboardBinding(),
      home: _checkingSession ? const _LoadingPage() : _startPage,
    );
  }
}

class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
