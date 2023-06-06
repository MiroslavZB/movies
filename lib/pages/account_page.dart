import 'package:movies/components/movie_card.dart';
import 'package:movies/controllers/user_controller.dart';
import 'package:movies/pages/home_page.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
              ElevatedButton(
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
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My List:',
                  style: styleH1Bold.copyWith(color: primaryColor),
                ),
              ),
              Consumer<UserController>(
                builder: (_, controller, __) {
                  if (controller.savedIndexes.isEmpty) {
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
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: ListView.builder(
                      itemCount: controller.savedIndexes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, i) => MovieCard(
                        movie: movies.firstWhere(
                          (e) => e.id == controller.savedIndexes[i],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
