import 'package:flutter/material.dart';

const _initialPage = 5.0;

class CoffeeBloc {
  final pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt(),
  );

  final pageTextController = PageController(initialPage: _initialPage.toInt());

  final currentPage = ValueNotifier<double>(_initialPage);
  final textPage = ValueNotifier<double>(_initialPage);

  void init() {
    pageCoffeeController.addListener(_coffeeScrollListner);
    pageTextController.addListener(_textScrollListner);
  }

  void _coffeeScrollListner() {
    currentPage.value = pageCoffeeController.page;
  }

  void _textScrollListner() {
    textPage.value = pageTextController.page;
  }

  void dispose() {
    pageCoffeeController.removeListener(_coffeeScrollListner);
    pageTextController.removeListener(_textScrollListner);
    pageCoffeeController.dispose();
    pageTextController.dispose();
  }
}

class CoffeeProvider extends InheritedWidget {
  final CoffeeBloc bloc;

  CoffeeProvider({@required this.bloc, Widget child}) : super(child: child);
  static CoffeeProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CoffeeProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldwidget) => false;
}
