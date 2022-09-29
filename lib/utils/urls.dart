import 'package:url_launcher/url_launcher.dart' as launch;

Future<void> launchWikiUrl(String species) async {
  species = species.replaceAll(" ", "_");
  Uri url = Uri.parse('https://en.wikipedia.org/wiki/$species');
  if (!await launch.launchUrl(url,
      mode: launch.LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

Future<void> launchGoogleUrl(String species) async {
  species = species.replaceAll(" ", "+");
  Uri url = Uri.parse('https://www.google.com/search?q=$species');
  if (!await launch.launchUrl(url,
      mode: launch.LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
