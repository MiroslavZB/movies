import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push(Paths.movieDetails, extra: movie),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(smallBorderRadius),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
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
    );
  }

  Widget titleAndWatchLater() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              movie.title,
              style: styleH1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO
          },
          icon: const Icon(
            Icons.watch_later_outlined,
            color: onPrimaryColor,
            size: mediumIconSize,
          ),
        )
      ],
    );
  }

  Widget poster() {
    return Expanded(
      child: Image.network(
        movie.posterUrl,
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
          Icon(icon, color: Colors.white,),
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
