import 'package:movies/components/movie_card.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';
import 'package:movies/services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

List<Movie> movies = [];

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appName,
          style: styleH1Bold.copyWith(color: accentColor),
        ),
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () => context.push(Paths.account),
            icon: const Icon(
              Icons.account_circle_outlined,
              color: onPrimaryColor,
            ),
          ),
          IconButton(
            onPressed: () => getMovies(),
            icon: const Icon(
              Icons.refresh,
              color: onPrimaryColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, i) => MovieCard(movie: movies[i]),
            ),
          )
        ],
      ),
    );
  }

  // Functions
  Future<void> getMovies() async {
    final parsed = await Client.get();
    List<Movie> movies_ = [];
    if (parsed is List) {
      for (Map e in parsed) {
        movies_.add(Movie.fromJson(e));
      }
    }
    setState(() {
      movies = movies_;
    });
  }
}
