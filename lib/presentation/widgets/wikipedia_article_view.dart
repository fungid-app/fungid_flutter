import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fungid_flutter/domain/wikipedia.dart';
import 'package:fungid_flutter/presentation/pages/view_species.dart';
import 'package:fungid_flutter/utils/ui_helpers.dart';
import 'package:fungid_flutter/utils/urls.dart';

class WikipediaArticleView extends StatelessWidget {
  final WikipediaArticle article;

  const WikipediaArticleView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiHelpers.sectionHeader(context, "Wikipedia"),
        const SizedBox(height: UiHelpers.itemSpacing),
        buildArticle(context, article),
      ],
    );
  }
}

TextSpan buildText(BuildContext context, WikipediaText text) {
  if (text is InternalWikipediaLink) {
    return TextSpan(
      text: text.text,
      style: UiHelpers.linkStyle(context),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          Navigator.push(
            context,
            ViewSpeciesPage.route(
              species: text.articleTitle,
              specieskey: null,
              observation: null,
            ),
          );
        },
    );
  } else if (text is ExternalWikipediaLink) {
    var gesture = TapGestureRecognizer()
      ..onTap = () {
        launchWikiUrl(text.articleTitle);
      };

    return TextSpan(
      children: [
        TextSpan(
          text: text.text,
          style: UiHelpers.linkStyle(context),
          recognizer: gesture,
        ),
        WidgetSpan(
          child: Icon(
            Icons.open_in_new,
            size: 12,
            color: UiHelpers.linkColor(context),
          ),
          alignment: PlaceholderAlignment.middle,
        ),
      ],
    );
  } else {
    return TextSpan(text: text.text);
  }
}

Widget buildParagraph(
  BuildContext context,
  WikipediaParagraph paragraph,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: RichText(
      text: TextSpan(
        children: paragraph.body.map((e) => buildText(context, e)).toList(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ),
  );
}

Widget buildTitle(BuildContext context, WikipediaTitle title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      title.title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
  );
}

Widget buildSection(BuildContext context, WikipediaSection section) {
  final theme = Theme.of(context);
  final iconColor = theme.colorScheme.primary;

  if (section.title == null) {
    return Column(
      children: section.body.map((e) => buildParagraph(context, e)).toList(),
    );
  } else {
    return ExpandablePanel(
      header: buildTitle(context, section.title!),
      theme: ExpandableThemeData(
        headerAlignment: ExpandablePanelHeaderAlignment.center,
        tapBodyToExpand: true,
        iconColor: iconColor,
      ),
      collapsed: const SizedBox.shrink(),
      expanded: Column(
        children: section.body.map((e) => buildParagraph(context, e)).toList(),
      ),
    );
  }
}

Widget buildArticle(BuildContext context, WikipediaArticle article) {
  return Column(
    children: article.sections.map((e) => buildSection(context, e)).toList(),
  );
}
