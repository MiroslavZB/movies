import 'package:movies/components/movie_card.dart';
import 'package:movies/controllers/user_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserController>(context, listen: false).getMovies();
  }

  String genre = defaultGenre;
  int year = 0;

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
            onPressed: () => Provider.of<UserController>(context, listen: false).getMovies(),
            icon: const Icon(
              Icons.refresh,
              color: onPrimaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer<UserController>(
          builder: (_, controller, __) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        genreDropDown(controller),
                        const Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Text('|', style: styleH1),
                        ),
                        yearDropDown(controller),
                      ],
                    ),
                  ),
                ),
                getMoviesList(controller),
              ],
            );
          },
        ),
      ),
    );
  }

  // Widgets
  Widget genreDropDown(UserController controller) {
    return DropdownButton<String>(
      dropdownColor: primaryColor,
      isDense: true,
      elevation: 24,
      iconSize: 35,
      value: genre,
      underline: const SizedBox.shrink(),
      onChanged: (String? value) {
        setState(() {
          genre = value ?? defaultGenre;
        });
      },
      menuMaxHeight: MediaQuery.of(context).size.height / 3,
      items: [defaultGenre, ...controller.genreSet].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              color: accentColor,
              fontWeight: value == genre && value != defaultGenre ? FontWeight.bold : FontWeight.normal,
              fontStyle: value == defaultGenre ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget yearDropDown(UserController controller) {
    return DropdownButton<int>(
      dropdownColor: primaryColor,
      isDense: true,
      elevation: 24,
      iconSize: 35,
      value: year,
      underline: const SizedBox.shrink(),
      onChanged: (int? value) {
        setState(() {
          year = value ?? defaultYear;
        });
      },
      menuMaxHeight: MediaQuery.of(context).size.height / 3,
      items: [defaultYear, ...controller.yearSet].map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            value == 0 ? 'All Years' : value.toString(),
            style: TextStyle(
              color: accentColor,
              fontWeight: value == year && value != defaultYear ? FontWeight.bold : FontWeight.normal,
              fontStyle: value == defaultYear ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget getMoviesList(UserController controller) {
    bool hasChange = false;
    List<Movie> movies_ = controller.movies;
    if (genre != defaultGenre) {
      movies_ = controller.movies.where((e) => e.genres.contains(genre)).toList();
      hasChange = true;
    }
    if (year != defaultYear) {
      movies_ = hasChange
          ? movies_.where((e) => e.year == year).toList()
          : controller.movies.where((e) => e.year == year).toList();
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: ListView.builder(
        itemCount: movies_.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => MovieCard(movie: movies_[i]),
      ),
    );
  }
}
