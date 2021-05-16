import 'package:coffee/coffee_concept/coffee.dart';
import 'package:flutter/material.dart';

class CoffeeConceptsDetails extends StatelessWidget {
  const CoffeeConceptsDetails({@required this.coffee, Key key})
      : super(key: key);
  final Coffee coffee;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: "cofee",
            child: Text(
              coffee.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        SizedBox(height: 20),
       Column(
            children: [
              Hero(
                tag: "${coffee.name}",
                child: Image.asset(
                  coffee.image,
                  height: size.height*0.4,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  '\$${coffee.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 45,
                  width: 165,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xffa89276))),
                    onPressed: () {},
                    child: Text('Buy',style: TextStyle(fontSize: 22),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
