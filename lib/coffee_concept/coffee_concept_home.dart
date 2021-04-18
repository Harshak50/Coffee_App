import 'package:coffee/coffee_concept/coffee.dart';
import 'package:coffee/coffee_concept/coffee_concept_list.dart';
import 'package:flutter/material.dart';

class CoffeeConceptHome extends StatelessWidget {
  const CoffeeConceptHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.primaryDelta < -20) {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 700),
                pageBuilder: (context, animation, _) {
                  return FadeTransition(
                    opacity: animation,
                    child: CoffeeConceptsList(),
                  );
                },
              ),
            );
          }
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffa89276),
                        Colors.white,
                      ]),
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.4,
              left: 0,
              top: size.height * 0.15,
              right: 0,
              child: Hero(
                tag: coffees[3].image,
                child: Image.asset(
                  coffees[3].image,
                ),
              ),
            ),
            Positioned(
              height: size.height * 0.6,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: coffees[4].image,
                child: Image.asset(
                  coffees[4].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * 0.77,
              child: Hero(
                tag: coffees[5].image,
                child: Image.asset(
                  coffees[5].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              height: 140,
              left: 0,
              right: 0,
              bottom: size.height * 0.25,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
