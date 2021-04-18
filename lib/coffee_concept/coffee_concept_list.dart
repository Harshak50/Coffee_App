import 'package:coffee/coffee_concept/coffee.dart';
import 'package:coffee/coffee_concept/coffee_bloc.dart';
import 'package:coffee/coffee_concept/coffee_concepts_details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const _duration = Duration(milliseconds: 200);


class CoffeeConceptsList extends StatefulWidget {
  @override
  _CoffeeConceptsListState createState() => _CoffeeConceptsListState();
}

class _CoffeeConceptsListState extends State<CoffeeConceptsList> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bloc = CoffeeProvider.of(context).bloc;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 90,
                  offset: Offset.zero,
                  spreadRadius: 45,
                )
              ]),
            ),
          ),
          ValueListenableBuilder<double>(
                valueListenable: bloc.currentPage,
                builder: (context, currentPage, _) {
                  return
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child:  PageView.builder(
                    controller: bloc.pageCoffeeController,
                    scrollDirection: Axis.vertical,
                    itemCount: coffees.length,
                    onPageChanged: (value) {
                      if (value < coffees.length) {
                        bloc.pageTextController.animateToPage(value,
                            duration: _duration, curve: Curves.easeOut);
                      }
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox.shrink();
                      }
                      final coffee = coffees[index - 1];
                      final result = currentPage - index + 1;
                      final value = -0.4 * result + 1;
                      final opacity = value.clamp(0.0, 1.0);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 700),
                              pageBuilder: (context, animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: CoffeeConceptsDetails(
                                    coffee: coffee,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)
                              ..translate(
                                0.0,
                                size.height / 2.6 * (1 - value).abs(),
                              )
                              ..scale(value),
                            child: Opacity(
                              opacity: opacity,
                              child: Hero(
                                tag: '${coffees[index].name}',
                                child: Image.asset(
                                  coffee.image,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

          );
                }
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: _CoffeeHeader(),
          ),
        ],
      ),
    );
  }
}

class _CoffeeHeader extends StatelessWidget {
  const _CoffeeHeader();
  @override
  Widget build(BuildContext context) {
    final bloc = CoffeeProvider.of(context).bloc;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0.0, -100 * value),
          child: child,
        );
      },
      duration: const Duration(milliseconds: 500),
      child:ValueListenableBuilder<double>(
        valueListenable: bloc.textPage,
        builder: (context, textPage,_) {
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: bloc.pageTextController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: coffees.length,
                  itemBuilder: (context, index) {
                    final opacity =
                        (1 - (index - textPage).abs()).clamp(0.0, 1.0);
                    return Opacity(
                        opacity: opacity,
                        child: Text(
                          coffees[index].name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ));
                  },
                ),
              ),
              AnimatedSwitcher(
                duration: _duration,
                child: Text(
                  '\$${coffees[textPage.toInt()].price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                key: Key(coffees[textPage.toInt()].name),
              ),
            ],
          );
        }
      ),
    );
  }
}
