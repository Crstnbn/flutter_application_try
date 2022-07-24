import 'package:flutter/widgets.dart';
import 'package:flutter_application_try/app/ui/pages/home/home_page.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/perfil_page.dart';
import 'package:flutter_application_try/app/ui/pages/perfil/read_page.dart';
import 'package:flutter_application_try/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:flutter_application_try/app/ui/routes/routes.dart';
import 'package:flutter_application_try/app/ui/splash/splash_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) => const HomePage(),
    Routes.PROFILE: (_) => ProfilePage(),
    Routes.READ: (_) => ReadPage(),
  };
}
