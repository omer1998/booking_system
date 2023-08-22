import 'package:booking_system/repositories/patient_repository_local.dart';
import 'package:booking_system/utilities/routes.dart';
import 'package:booking_system/views/pages/auth/patient_page/sign_in/p_sign_in_controller.dart';
import 'package:booking_system/views/pages/auth/patient_page/sign_up/p_sign_up_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initializing hive
  await Hive.initFlutter();
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      builder: EasyLoading.init(), // for showing loading
      onGenerateTitle: (context) => AppLocalizations.of(context)!.helloWorld,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("en"), Locale("ar")],
      // or in other way
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // useMaterial3: true
      ),

      initialRoute: Routes.home,
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    ref
        .read(patientSignInNotifierProvider.notifier)
        .checkPatientAuthValidation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.patientSignUp);
              },
              child: Text("Sign Up as Patient")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.doctorSetup);
              },
              child: Text("Sign Up as Doctor"))
        ],
      )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
