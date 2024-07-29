import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '행덕',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          surfaceTint: Colors.white,
          brightness: Brightness.light,
          primary: Color.fromRGBO(241, 80, 40, 100),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(241, 80, 40, 100),
          onSecondary: Colors.white,
          error: Colors.red, //Temporary
          onError: Colors.white, //Temporary
          background: Colors.white,
          onBackground: Color(0xFF181818), surface: Color(0xFFFCFCFF),
          onSurface: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '행덕'),
    );
  }
}

///Text theme
TextTheme tt(BuildContext context) => Theme.of(context).textTheme;

//Color scheme
ColorScheme cs(BuildContext context) => Theme.of(context).colorScheme;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/images/image12.png"),
                width: 100,
              ),
              Text(
                "행덕",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
              child: TextButton(
            child: const Text('Login'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
          ))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
