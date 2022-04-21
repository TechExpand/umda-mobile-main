import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/controller/authprovider.dart';
import 'package:shop_app/controller/cartProvider.dart';
import 'package:shop_app/controller/homeProvider.dart';
import 'package:shop_app/controller/profileProvider.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/login_success/login_success_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';
import 'package:get_it/get_it.dart';

import 'controller/orderProvider.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerLazySingleton<AuthProvider>(() => AuthProvider());
  getIt.registerLazySingleton<HomeProvider>(() => HomeProvider());
  getIt.registerLazySingleton<OrderProvider>(() => OrderProvider());
  getIt.registerLazySingleton<ProfileProvider>(() => ProfileProvider());
  getIt.registerLazySingleton<CartProvider>(() => CartProvider());
  Widget widget = await decideFirstWidget();
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => getIt<AuthProvider>()),
        ChangeNotifierProvider<OrderProvider>(
            create: (context) => getIt<OrderProvider>()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => getIt<HomeProvider>()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (context) => getIt<ProfileProvider>()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => getIt<CartProvider>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UMDA',
        theme: theme(),
        home: widget,
        // We use routeName so that we dont need to remember the name
        // initialRoute: SplashScreen.routeName,
        // routes: routes,
      ),
    );
  }
}

Future<Widget> decideFirstWidget() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var first = prefs.getString('first');

  if (token == null || token == 'null') {
    if (first == null) {
      prefs.setString('first', 'first');
      return SplashScreen();
    } else {
      //return Register();
      return SignInScreen();
    }
  } else {
    return HomeScreen();
    //return BankAccountSuccess();
    // return BottomNav();
  }
}
