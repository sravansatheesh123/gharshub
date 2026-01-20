import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gharshub/screen/auth/login_page.dart';
import 'package:gharshub/screen/auth/reset_password_page.dart';

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

  @override
  void initState() {
    super.initState();
    _listenDeepLinks();
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
      home: LoginPage(),
    );
  }
}
