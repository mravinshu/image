import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hovering/hovering.dart';

class imageView extends StatefulWidget {
  final String path;
  const imageView({Key? key, required this.path}) : super(key: key);

  @override
  State<imageView> createState() => _imageViewState();
}

class _imageViewState extends State<imageView> {
  final labelController = TextEditingController();

  int noOfClicks = 0;

  List<double> width = [];
  List<double> height = [];
  List<String> label = [];

  dataAddOn(double w, double h, String value) {
    width.add(w);
    height.add(h);
    label.add(value);
    setState(() {
      noOfClicks = noOfClicks + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData device = MediaQuery.of(context);

    return Container(
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          // print(event);
          // print(device.size.width);
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Enter Label'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      TextField(
                        controller: labelController,
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Approve'),
                    onPressed: () {
                      String inde = event.position.toString();
                      int index = inde.indexOf(",");
                      int endindex = inde.indexOf(")");
                      // print(event.position.toString().substring(index+2,endindex));
                      dataAddOn(
                          double.parse(
                              event.position.toString().substring(7, index)),
                          double.parse(event.position
                              .toString()
                              .substring(index + 2, endindex)),
                          labelController.text.toString());
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(widget.path),
            for (int i = 0; i < noOfClicks; i++)
              Positioned(
                top: height[i],
                left: width[i],
                child: GestureDetector(
                  onTap: () {
                    print("Maybe tap");
                  },
                  child: HoverWidget(
                      hoverChild: Container(
                        color: Colors.red,
                        height: 20,
                        width: 20,
                      ),
                      onHover: (PointerEnterEvent event) {},
                      child: Container(
                        color: Colors.red,
                        height: 10,
                        width: 10,
                      )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
