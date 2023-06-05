import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(smallBorderRadius),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    movie.title,
                    style: styleH1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
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
                ),
              ],
            ),
          ),
        ),
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
