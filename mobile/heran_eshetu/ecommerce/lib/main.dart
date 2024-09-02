import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/injection/injection.dart' as di;
import 'bloc_observer.dart';
import 'core/utils/bloc_provider.dart';
import 'features/auth/presentation/screens/signin_page.dart';
import 'features/auth/presentation/screens/signup_page.dart';
import 'features/auth/presentation/screens/splash_screen.dart';
import 'features/chat/presentation/pages/chat_list_page.dart';
import 'features/product/domain/entitity/user.dart';
import 'features/product/presentation/screens/add_product_page.dart';
import 'features/product/presentation/screens/homepage.dart';
import 'features/product/presentation/screens/product_detail_page.dart';
import 'features/product/presentation/screens/search_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final BlocMultiProvider blocMultiProvider = BlocMultiProvider();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocMultiProvider.blocMultiProvider(),
      child: FutureBuilder<String>(
        future: AppRouter._determineInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final initialRoute = snapshot.data ?? '/signin_page';

          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 35, 51, 203),
              ),
              useMaterial3: true,
              textTheme: const TextTheme(
                bodyLarge: TextStyle(fontFamily: 'Poppins'),
                bodyMedium: TextStyle(fontFamily: 'Poppins'),
                bodySmall: TextStyle(fontFamily: 'Poppins'),
                displayLarge: TextStyle(fontFamily: 'Poppins'),
                displayMedium: TextStyle(fontFamily: 'Poppins'),
                displaySmall: TextStyle(fontFamily: 'Poppins'),
                headlineLarge: TextStyle(fontFamily: 'Poppins'),
                headlineMedium: TextStyle(fontFamily: 'Poppins'),
                headlineSmall: TextStyle(fontFamily: 'Poppins'),
                titleLarge: TextStyle(fontFamily: 'Poppins'),
                titleMedium: TextStyle(fontFamily: 'Poppins'),
                titleSmall: TextStyle(fontFamily: 'Poppins'),
                labelLarge: TextStyle(fontFamily: 'Poppins'),
                labelMedium: TextStyle(fontFamily: 'Poppins'),
                labelSmall: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
            initialRoute: initialRoute,
            routes: {
              '/splash_page': (context) => const SplashScreen(),
              '/signin_page': (context) => SigninPage(),
              '/signup_page': (context) => SignupPage(),
              '/product_detail_page': (context) => _buildPageWithUser(
                    context,
                    (user) => ProductDetailPage(user: user),
                  ),
              '/add_product_page': (context) => _buildPageWithUser(
                    context,
                    (user) => AddProductPage(user: user),
                  ),
              '/homepage': (context) => _buildPageWithUser(
                    context,
                    (user) => HomePage(user: user),
                  ),
              '/search_page': (context) => const SearchPage(),
              '/chat_list_page': (context) => const ChatListPage(),
            },
          );
        },
      ),
    );
  }

  Widget _buildPageWithUser(
      BuildContext context, Widget Function(User) pageBuilder) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return SigninPage();
        } else if (snapshot.hasData) {
          final prefs = snapshot.data!;
          final userId = prefs.getString('user_id');
          final userName = prefs.getString('user_name');
          final userEmail = prefs.getString('user_email');

          if (userId != null && userName != null && userEmail != null) {
            final user = User(id: userId, name: userName, email: userEmail);
            return pageBuilder(user);
          } else {
            return SigninPage();
          }
        } else {
          return SigninPage();
        }
      },
    );
  }
}

class AppRouter {
  static Future<String> _determineInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id');
    final userName = prefs.getString('user_name');
    final userEmail = prefs.getString('user_email');

    if (userId != null && userName != null && userEmail != null) {
      return '/homepage';
    } else {
      return '/signin_page';
    }
  }

  // static Future<String?> _getToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('tokenKey');
  //   return token;
  // }
}
