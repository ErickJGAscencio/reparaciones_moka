import 'package:flutter/material.dart';
import 'package:reparaciones_moka/features/auth/presentacion/inicio_sesion_screen.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/ordenes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Verificamos si hay token
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString("token");
  final token = "";

  runApp(MyApp(isLoggedIn: token != "" ? false : true));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn ? const OrdenesScreen() : const InicioSesionScreen(),
    );
  }
}

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,      
        title: Text(widget.title),
      ),
      body: InicioSesionScreen(),
    );
  }
}
