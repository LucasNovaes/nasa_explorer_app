import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/page_presenter.dart';

import 'widgets/base_page.dart';

class DetailPage extends StatelessWidget {
  final PagePresenter presenter;
  const DetailPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaData = presenter.mediaNotifier.value;
    return BasePage(
        state: presenter.pageState,
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.network(
                mediaData!.url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mediaData.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      mediaData.date,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      mediaData.explanation,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
