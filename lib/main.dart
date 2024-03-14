import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: "Product animation demo home page", animation: animation),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget{
  final String title;
  final Animation<double> animation;

  const MyHomePage({super.key, required this.title, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product List"),),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10, 2, 10),
        children: [
          FadeTransition(
              opacity: animation,
              child: const ProductBox(
                name: "IPhone",
                des: "IPhone is the most stylist phone ever",
                price: 1000,
                image: "iphone.jpg",
              ),
          ),
          MyAnimatedWidget(animation: animation,
              child: const ProductBox(
                name: "Pixel",
                des: "Pixel is the most featureful phone",
                price: 800,
                image: "pixel.jpg",
          )),
          const ProductBox(name: "Laptop", des: "Laptop is abc", price: 2000, image: "laptop.jpg"),
          const ProductBox(name: "Tablet", des: "Tablet is abc", price: 2000, image: "tablet.jpg"),
          const ProductBox(name: "Pendrive", des: "Pendrive is abc", price: 2000, image: "pendrive.jpg"),
          const ProductBox(name: "Floppy Drive", des: "Floppy Drive is abc", price: 2000, image: "floppydisk.jpg"),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {

  final String name;
  final String des;
  final int price;
  final String image;

  const ProductBox({super.key, required this.name, required this.des, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 140,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/$image"),
            Expanded(child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),),
                  Text(des, style: const TextStyle(fontSize: 10),),
                  Text("Price: $price")
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class MyAnimatedWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const MyAnimatedWidget({super.key, required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            child: Opacity(opacity: animation.value, child: child,),
          );
        },
      ),
    );
  }
}