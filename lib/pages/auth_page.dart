import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/controllers/user_controller.dart';
import 'package:movies/models/binary_alert.dart';
import 'package:movies/resources/utils.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appNameText(),
            googleLogIn(context),
            const Text('or', style: styleH2Bold),
            guestLogIn(context),
          ],
        ),
      ),
    );
  }

  // Widgets
  appNameText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appName,
          style: styleH1.copyWith(
            fontSize: 60,
            color: accentColor,
          ),
        ),
      ],
    );
  }

  googleLogIn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final googleSignIn = GoogleSignIn();
        try {
          final GoogleSignInAccount? account = await googleSignIn.signIn();
          if (account != null && context.mounted) {
            final controller = Provider.of<UserController>(context, listen: false);
            controller.setKey(account.email);
            controller.fetch();
            context.push(Paths.home);
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Auth was unsuccessful!'),
            ),
          );
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: onPrimaryColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/google-logo.png',
                width: 24,
                height: 24,
              ),
            ),
            const Text(
              'Sign in with Google',
              style: styleH4,
            ),
          ],
        ),
      ),
    );
  }

  guestLogIn(BuildContext context) {
    return ElevatedButton(
      onPressed: () => binaryDialog(
        context,
        question: "Are you sure you want to continue as guest? "
            "Movies you bookmark won't be visible on other devices.",
        positiveOnTap: () {
          context.pop();
          final controller = Provider.of<UserController>(context, listen: false);
          controller.setKey('guest');
          controller.fetch();
          context.push(Paths.home);
        },
        insetPadding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height / 5,
          left: 20,
          right: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
      ),
      child: const Text(
        'Continue as guest',
        style: styleH4,
      ),
    );
  }
}
