import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/pages/widgets/base_page.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/home_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePresenter homePresenter;
  const HomePage({
    Key? key,
    required this.homePresenter,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.homePresenter.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      state: widget.homePresenter.pageState,
      child: ValueListenableBuilder(
        valueListenable: widget.homePresenter.mediaList,
        builder: (context, list, _) {
          return Column(children: [
            if (list.isNotEmpty) ...[
              ...list.map<Widget>((MediaEntity e) {
                return Container(
                  child: Text(e.title),
                );
              }),
            ]
          ]);
        },
      ),
    );
  }
}
