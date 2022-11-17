class WikipediaText {
  String text;

  WikipediaText({
    required this.text,
  });
}

class WikipediaParagraph {
  List<WikipediaText> body;

  WikipediaParagraph({
    required this.body,
  });
}

class WikipediaTitle {
  String title;

  WikipediaTitle({
    required this.title,
  });
}

abstract class WikipediaLink extends WikipediaText {
  String articleTitle;

  WikipediaLink({
    required text,
    required this.articleTitle,
  }) : super(text: text);
}

class InternalWikipediaLink extends WikipediaLink {
  InternalWikipediaLink({
    required text,
    required articleTitle,
  }) : super(text: text, articleTitle: articleTitle);
}

class ExternalWikipediaLink extends WikipediaLink {
  ExternalWikipediaLink({
    required text,
    required articleTitle,
  }) : super(text: text, articleTitle: articleTitle);
}

class WikipediaSection {
  WikipediaTitle? title;
  int depth;
  List<WikipediaParagraph> body;
  WikipediaSection({
    required this.body,
    this.title,
    depth,
  }) : depth = depth ?? 0;
}

class WikipediaArticle {
  List<WikipediaSection> sections;
  WikipediaArticle({
    required this.sections,
  });
}
