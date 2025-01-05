import 'package:deliveryapp/common/providers/local/cache_provider.dart';
import 'package:deliveryapp/common/providers/remote/api_provider.dart';
import 'package:deliveryapp/common/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await CacheProvider.init();
  ApiProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: GetMaterialApp(
        getPages: AppRoute.pages,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoute.splash,
      ),
    );
  }
}
