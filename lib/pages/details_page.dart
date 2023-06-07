import 'package:movies/models/movie.dart';
import 'package:movies/resources/utils.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> details = movie.toJson().entries.where((e) {
      dynamic v = e.value;
      if (v == null) return false;
      if (v is String) return v.isNotEmpty;
      if (v is List) return v.isNotEmpty;
      return true;
    }).toList();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(movie.title, style: styleH3Bold),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: onPrimaryColor,
            thickness: 3,
          ),
          if (movie.date != null)
            detailEntry(
              MapEntry(
                'Release date',
                formatDateTimeA(movie.date!),
              ),
            ),
          if (movie.duration_ != null)
            detailEntry(
              MapEntry(
                'Duration',
                '${movie.duration_!.inMinutes} minutes',
              ),
            ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: details.length,
              itemBuilder: (_, i) => detailEntry(details[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailEntry(MapEntry<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${e.key}: ',
              style: styleH4,
            ),
            TextSpan(
              text: (e.value is List) ? e.value.join(', ') : e.value.toString(),
              style: styleH3Bold,
            ),
          ],
        ),
      ),
    );
  }
}
