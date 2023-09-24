import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/states/page_state.dart';

class BasePage extends StatefulWidget {
  final ValueNotifier<PageState> state;
  final VoidCallback? onSuccess;
  final Widget child;
  final SearchBar? searchBar;
  final Function()? onRefreshBtnPressed;
  final Function()? onErrorDialogBtnPressed;

  const BasePage({
    Key? key,
    this.searchBar,
    required this.state,
    this.onSuccess,
    required this.child,
    this.onRefreshBtnPressed,
    this.onErrorDialogBtnPressed,
  }) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late BuildContext _context;

  @override
  void initState() {
    widget.state.addListener(() {
      final currState = widget.state.value;
      if (currState is PageStateError) {
        showDialog(
            context: _context,
            builder: (BuildContext builder) => AlertDialog(
                  title: Text(currState.description),
                  icon: const Icon(Icons.error),
                  actions: [
                    TextButton(
                      onPressed: widget.onErrorDialogBtnPressed ??
                          () {
                            Navigator.of(context).pop();
                          },
                      child: const Text("OK"),
                    )
                  ],
                ));
      }
      if (currState is PageStateSuccess && widget.onSuccess != null) {
        widget.onSuccess!();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('NASA Explorer App'),
            actions: [
              if (widget.onRefreshBtnPressed != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white70;
                        },
                      ),
                    ),
                    onPressed: widget.onRefreshBtnPressed,
                    child: const Icon(
                      Icons.refresh,
                    ),
                  ),
                )
            ],
          ),
          body: Column(
            children: [
              if (widget.searchBar != null) widget.searchBar!,
              Expanded(child: widget.child),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: widget.state,
          builder: (context, state, _) {
            return state is PageStateLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
