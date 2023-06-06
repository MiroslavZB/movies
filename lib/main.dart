import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies/controllers/user_controller.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/pages/account_page.dart';
import 'package:movies/pages/auth_page.dart';
import 'package:movies/pages/details_page.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: Paths.auth,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.auth,
      name: Paths.auth,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: const AuthPage(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.home,
      name: Paths.home,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: const HomePage(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.movieDetails,
      name: Paths.movieDetails,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: DetailsPage(movie: state.extra as Movie),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.account,
      name: Paths.account,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          child: const AccountPage(),
        );
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(),
        ),
      ],
      child: MaterialApp.router(
        title: appName,
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
        theme: ThemeData(
          primarySwatch: primaryColor,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
