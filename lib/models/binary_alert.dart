import 'package:movies/resources/utils.dart';

binaryDialog(
  BuildContext context, {
  required String question,
  required Function() positiveOnTap,
  String negativeText = 'No',
  String positiveText = 'Yes',
  void Function()? negativeOnTap,
  EdgeInsets insetPadding = const EdgeInsets.only(left: 20, right: 20),
}) {
  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: insetPadding,
      backgroundColor: backgroundColor.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(smallBorderRadius)),
      content: Text(
        question,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
          ),
          onPressed: negativeOnTap ?? () => context.pop(),
          child: Text(
            negativeText,
            style: styleH4.copyWith(color: onAccentColor),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
          ),
          onPressed: positiveOnTap,
          child: Text(
            positiveText,
            style: styleH4.copyWith(color: onAccentColor),
          ),
        )
      ],
    ),
  );
}
