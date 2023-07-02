
import 'package:booking_system/controller/authController.dart';
import 'package:booking_system/locale/locale.dart';
import 'package:booking_system/utilities/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(create: (context) => AuthController(),
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
<<<<<<< Updated upstream
      onGenerateTitle: (context)=> AppLocalization.of(context).doctors,
      localizationsDelegates: [
=======
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
      localizationsDelegates:const [
        AppLocalizations.delegate,
>>>>>>> Stashed changes
        GlobalMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales:  [
        Locale("en",""),
        Locale("ar", "")
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true
      ),
      initialRoute: Routes.mainPage,
      onGenerateRoute: (settings) => onGenerateRoute(settings),
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
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [ElevatedButton(onPressed: (){
          Navigator.pushNamed(context,Routes.signIn);
        }, child: const Text("Login"))],)    
        ),
      
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  
}
}