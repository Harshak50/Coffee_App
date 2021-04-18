import 'package:coffee/coffee_concept/coffee_bloc.dart';
import 'package:coffee/coffee_concept/coffee_concept_home.dart';
import 'package:flutter/material.dart';

class MainCoffeeConceptApp extends StatefulWidget {
  @override
  _MainCoffeeConceptAppState createState() => _MainCoffeeConceptAppState();
}

class _MainCoffeeConceptAppState extends State<MainCoffeeConceptApp> {
  final bloc = CoffeeBloc();
    @override
    void initState() {
      bloc.init();
      super.initState();
    }

    @override
    void dispose() {
      bloc.dispose();
      super.dispose();
    }
  Widget build(BuildContext context) {

    return Theme(
      data: ThemeData.light(),
      child: CoffeeProvider(
        bloc: bloc,
        child: MaterialApp(
            debugShowCheckedModeBanner: false, home: CoffeeConceptHome()),
      ),
    );
  }
}
