import 'package:flutter/material.dart';
import 'package:image_app/image_comparator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: ImageWithTitle(
                "Image A",
                Image.asset("assets/images/original_image.png"),
              )),
              Expanded(
                child: ImageWithTitle(
                  "Image B",
                  Image.asset("assets/images/modified_image.png"),
                ),
              ),
            ],
          ),
          ImageWithTitle(
            "Difference",
            FutureBuilder<Image>(
              future: ImageComparator.compareImages(
                  "assets/images/original_image.png",
                  "assets/images/modified_image.png"),
              builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else
                  return CircularProgressIndicator(
                    backgroundColor: Colors.cyanAccent,
                    strokeWidth: 5,
                  );
              },
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ImageWithTitle extends StatelessWidget {
  final String title;
  final Widget child;

  ImageWithTitle(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 8,
          ),
          child,
        ],
      ),
    );
  }
}
