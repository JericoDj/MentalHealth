
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:llps_mental_app/routes/app_routes.dart';
import 'package:llps_mental_app/utils/bindings/general_bindings.dart';
import 'package:llps_mental_app/utils/constants/colors.dart';
import 'package:llps_mental_app/utils/theme/theme.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      /// Show Loader or Circular progress indicator meanwhile Authentication repository is deciding to show relevant screen.
      home: const Scaffold(backgroundColor: MyColors.color1, body:  Center(child: CircularProgressIndicator(color: MyColors.white,),)),
    );
  }
}