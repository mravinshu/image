import 'package:flutter/material.dart';
import 'package:image/imageView.dart';

class imageScreenViewer extends StatefulWidget {
  const imageScreenViewer({Key? key}) : super(key: key);

  @override
  State<imageScreenViewer> createState() => _imageScreenViewerState();
}

class _imageScreenViewerState extends State<imageScreenViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
          itemCount: 2,
          itemBuilder: (BuildContext context,int index){
        String path = "assets/$index.png";
        return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => imageView(path: path),
                ),
              );
            },

            child: Image.asset(path));
      }),
    );
  }
}
