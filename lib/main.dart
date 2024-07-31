import 'package:flutter/material.dart';
import 'package:sparcs_fe/pages/login.dart';
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
      title: '동심동덕',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          surfaceTint: Colors.white,
          brightness: Brightness.light,
          primary: Color.fromRGBO(241, 80, 40, 1),
          onPrimary: Colors.white,
          secondary: Color.fromRGBO(241, 80, 40, 1),
          onSecondary: Colors.white,
          error: Colors.red, //Temporary
          onError: Colors.white, //Temporary
          background: Colors.white,
          onBackground: Color(0xFF181818), surface: Color(0xFFFCFCFF),
          onSurface: Colors.black,
        ),
        textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'PretendardBold', fontSize: 18),
            titleLarge:
                TextStyle(fontFamily: 'PretendardSemiBold', fontSize: 18),
            labelLarge: TextStyle(
                fontFamily: 'PretendardSemiBold',
                fontSize: 12,
                color: Color.fromRGBO(241, 80, 40, 1)),
            labelMedium: TextStyle(
                fontFamily: 'PretendardSemiBold',
                fontSize: 12,
                color: Color.fromRGBO(27, 180, 0, 1)),
            headlineLarge: TextStyle(
              fontFamily: 'PretendardSemiBold',
              fontSize: 18,
              color: Colors.white,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'PretendardBold',
              fontSize: 16,
              color: Color.fromRGBO(255, 134, 87, 1),
            ),
            labelSmall: TextStyle(
                fontFamily: 'PretendardSemiBold',
                fontSize: 12,
                color: Color.fromRGBO(255, 255, 255, 1)),
            bodyMedium: TextStyle(
              fontFamily: 'PretendardRegular',
              fontSize: 16,
            )),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '동심동덕'),
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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/sparcs_logo.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                  child: GestureDetector(
                child: const Image(
                    image: AssetImage('assets/images/startButton.png')),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
              ))
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
