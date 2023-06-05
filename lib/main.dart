import 'package:movies/models/movie.dart';
import 'package:movies/pages/details_page.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/resources/utils.dart';

void main() {
  runApp(const MyApp());
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: Paths.home,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Paths.home,
      name: Paths.home,
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomePage(),
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
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: primaryColor,
        fontFamily: 'Montserrat',
      ),
    );
  }
}
