import 'package:movies/controllers/user_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: InkWell(
        onTap: () => context.push(Paths.movieDetails, extra: movie),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(smallBorderRadius),
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  titleAndWatchLater(),
                  poster(),
                  rating(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widgets
  Widget titleAndWatchLater() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              movie.title,
              style: styleH2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Consumer<UserController>(
          builder: (_, controller, __) {
            final bool state = controller.savedIndexes.contains(movie.id);
            return Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: outlinedButtonColor,
                  border: Border.all(
                    color: outlineColor,
                  )),
              child: IconButton(
                onPressed: () {
                  if (state) {
                    controller.removeId(movie.id);
                  } else {
                    controller.addId(movie.id);
                  }
                },
                icon: Icon(
                  state ? Icons.done : Icons.add,
                  color: onPrimaryColor,
                  size: mediumIconSize,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget poster() {
    return Expanded(
      child: Image.network(
        movie.posterUrl,
        fit: BoxFit.fitWidth,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: frame != null ? child : placeholder(),
            );
          }
        },
        errorBuilder: (_, __, ___) => placeholder(),
      ),
    );
  }

  Widget rating() {
    IconData icon;
    if (movie.averageRating == '0') return Container();
    if ((double.tryParse(movie.averageRating) ?? 0) < 8) {
      icon = Icons.star_half_outlined;
    } else {
      icon = Icons.star;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${movie.averageRating} / 10',
            style: styleH3,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget placeholder() {
    return const Center(
      child: Text(
        'COMING SOON!',
        textAlign: TextAlign.center,
        style: styleH1,
      ),
    );
  }
}
