import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  String image = "https://http.cat/100";

  void _search(String code) {
    try {
      http.post(Uri.parse("https://http.cat/$code")).then((value) {
        if (value.statusCode == 405) {
          setState(() {
            image = "https://http.cat/$code";
            _controller.text = "";
          });
        } else {
          setState(() {
            _controller.text = "";
            image = "https://http.cat/404";
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  _controllerListener() {
    if (_controller.text.length == 3) {
      _search(_controller.text);
    }
  }

  @override
  void initState() {
    _controller.addListener(_controllerListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 50,
              ),
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Any weird HTTP code that you don't know?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      "No, problem. I got you covered.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'SF Pro',
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.justify,
                    )
                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              width: double.infinity,
              height: 40,
              child: CupertinoTextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.normal,
                ),
                placeholder: "Search",
                placeholderStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.normal,
                ),
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.black,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
