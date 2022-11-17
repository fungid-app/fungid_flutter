import 'dart:io';

import 'package:fungid_flutter/domain/wikipedia.dart';
import 'package:fungid_flutter/utils/iterables.dart';

class WikipediaArticleProvider {
  String wikiPath;
  WikipediaArticleProvider({
    required this.wikiPath,
  });

  Future<File?> getFile(String species) async {
    final file = File('$wikiPath/species/$species.wiki');
    return await file.exists() ? file : null;
  }

  Future<WikipediaArticle?> getSpeciesArticle(
    String species,
    Future<bool> Function(String) isSpeciesActive,
  ) async {
    final file = await getFile(species);
    if (file != null) {
      final contents = await file.readAsString();
      return await articleFromWikiText(contents, isSpeciesActive);
    }

    return null;
  }

  Future<WikipediaArticle> articleFromWikiText(
    String wikiText,
    Future<bool> Function(String) isSpeciesActive,
  ) async {
    List<WikipediaSection> sections = [];
    List<WikipediaParagraph> body = [];
    int depth = 0;

    WikipediaTitle? title;
    wikiText = wikiText.replaceAll('&nbsp;', ' ');

    for (String line in wikiText.split('\n')) {
      if (line.startsWith('==')) {
        if (body.isNotEmpty) {
          sections.add(WikipediaSection(
            title: title,
            body: body,
            depth: depth,
          ));

          body = [];
        }

        title = WikipediaTitle(title: line.replaceAll('=', ''));
        depth = line.length - line.replaceAll('=', '').length;
      } else {
        if (line.trim() != '') {
          body.add(await paragraphFromWikiText(
            line,
            isSpeciesActive,
          ));
        }
      }
    }

    if (body.isNotEmpty) {
      sections.add(WikipediaSection(
        title: title,
        body: body,
        depth: depth,
      ));
    }

    return WikipediaArticle(sections: sections);
  }

  Future<WikipediaParagraph> paragraphFromWikiText(
    String wikiText,
    Future<bool> Function(String) isSpeciesActive,
  ) async {
    return WikipediaParagraph(
      body: await splitWikiLinks(
        wikiText,
        isSpeciesActive,
      ),
    );
  }

  Future<List<WikipediaText>> splitWikiLinks(
    String wikiText,
    Future<bool> Function(String) isSpeciesActive,
  ) async {
    RegExp wikiParts = RegExp(r'\[\[(.*?)\]\]');
    var textParts =
        wikiText.split(wikiParts).map((e) => WikipediaText(text: e));

    var linkParts = await Future.wait(
      wikiParts
          .allMatches(wikiText)
          .map((e) async => await parseLink(e.group(1)!, isSpeciesActive)),
    );

    if (wikiText.startsWith('[[')) {
      return zip(linkParts, textParts).toList();
    }
    return zip(textParts, linkParts).toList();
  }

  Future<WikipediaText> parseLink(
    String text,
    Future<bool> Function(String) isSpeciesActive,
  ) async {
    if (text.startsWith('File:')) {
      return WikipediaText(text: '');
    }

    var linkParts = text.split('|');
    String articleTitle = linkParts[0];
    String linkText = linkParts.length > 1 ? linkParts[1] : linkParts[0];

    var file = await getFile(articleTitle);
    if (file != null && await isSpeciesActive(articleTitle)) {
      return InternalWikipediaLink(
        text: linkText,
        articleTitle: articleTitle,
      );
    } else {
      return ExternalWikipediaLink(
        text: linkText,
        articleTitle: articleTitle,
      );
    }
  }
}
