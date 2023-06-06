import 'package:movies/components/movie_card.dart';
import 'package:movies/controllers/user_controller.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: styleH1Bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              exitButton(context),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Saved to My List:',
                  style: styleH1Bold.copyWith(color: primaryColor),
                ),
              ),
              Consumer<UserController>(
                builder: (_, controller, __) {
                  if (controller.savedIndexes.isEmpty) {
                    return emptyAndRedirect(context);
                  }
                  return bookmarkedMovies(context, controller);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widgets
  Widget exitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.pushReplacement(Paths.auth),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Exit', style: styleH4Bold),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }

  Widget emptyAndRedirect(BuildContext context) {
    return Row(
      children: [
        Text(
          'Nothing here.',
          style: styleH4.copyWith(color: primaryColor),
        ),
        InkWell(
          onTap: () => context.pushReplacement(Paths.home),
          child: Text(
            ' Add?',
            style: styleH4Bold.copyWith(
              color: primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget bookmarkedMovies(BuildContext context, UserController controller) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: ListView.builder(
        itemCount: controller.savedIndexes.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          if (controller.movies.where((e) => e.id == controller.savedIndexes[i]).isEmpty) {
            return Container();
          }
          return MovieCard(
            movie: controller.movies.firstWhere(
              (e) => e.id == controller.savedIndexes[i],
            ),
          );
        },
      ),
    );
  }
}
