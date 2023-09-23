import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/pages/widgets/base_page.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/page_presenter.dart';

class HomePage extends StatefulWidget {
  final PagePresenter presenter;
  const HomePage({
    Key? key,
    required this.presenter,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.presenter.init();
    widget.presenter.getMediaList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      state: widget.presenter.pageState,
      child: ValueListenableBuilder(
        valueListenable: widget.presenter.mediaList,
        builder: (context, list, _) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final MediaEntity e = list[index];
              return Card(
                elevation: 1,
                child: ListTile(
                  splashColor:
                      const Color.fromARGB(255, 7, 172, 255).withOpacity(0.3),
                  isThreeLine: true,
                  title: Text(e.title),
                  subtitle: Text(e.date),
                  onTap: () {
                    widget.presenter.setMedia(e);
                    Navigator.of(context).pushNamed("/detail");
                  },
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
