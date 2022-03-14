import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'imageScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Image'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  List<String> name = [];
  List<String> email = [];
  List<String> pass = [];

  jsonCall() async {
    var raw = await http.get(
      Uri.parse(
          "https://www.googleapis.com/drive/v3/files/1jz1igdu0c90Xyy-fsnc_ib0CefLxE_Yl?alt=media&key=AIzaSyAHZvpRfSSLv8d-PAStwwTzmig4VGx3a1o"),
    );
    var jsonData = convert.jsonDecode(raw.body);
    jsonData.forEach((element) {
      name.add(element['name'].toString());
      email.add(element['email'].toString());
      pass.add(element['pass'].toString());
    });
  }

  // Future signUp(String email,String pass) async{
  //   print("here");
  //   email = emailController.text.toString();
  //   pass = passController.text.toString();
  //   final response = http.post(
  //     Uri.parse('https://graph.microsoft.com/v1.0/me/drive'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: convert.jsonEncode(<String, String>{
  //       'email': email,
  //       'password':pass,
  //       'name':"Ravinshu"
  //     }),
  //   );
  //   print(response.whenComplete(() => print("Done")));
  // }


  @override
  void initState() {
    super.initState();
    jsonCall();
  }

  bool checkPass() {
    int index = email.indexOf(emailController.text.toString());
    if (index > 0) {
      if( pass[index].contains(pass[index])){
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passController,
              ),
            ),
            ElevatedButton(
              // onLongPress: (){
              //   signUp(emailController.text.toString(), passController.text.toString());
              // },
                onPressed: () {
                  checkPass()
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => imageScreenViewer(),
                          ),
                        )
                      : print("Nhi Mila");
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
