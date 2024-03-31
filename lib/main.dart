import 'package:firebase_core/firebase_core.dart'; //This package is used to initialize Firebase services.
import 'package:flutter/material.dart'; //The core Flutter framework.
import 'package:path_provider/path_provider.dart'; //A Flutter plugin for finding commonly used locations on the filesystem.
import 'package:taskapp/firebase_options.dart'; //File containing Firebase configuration options.
import 'package:taskapp/screens/tabs/widgets/splash_screen.dart'; //File containing the splash screen widget.
import 'blocs/bloc_exports.dart'; //File exporting necessary BLoC-related files.
import 'services/app_router.dart'; // File containing the application router.
import 'services/app_theme.dart'; //File containing the application theme configurations.



///This is the entry point of the application. It initializes Firebase services,
/// sets up HydratedStorage for BLoCs,and then runs the MyApp widget.
/// 'async' Asynchronous operations allow a program to continue executing other tasks while waiting for a particular operation to complete,
/// such as fetching data from a server, reading a file, or performing a time-consuming computation.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  ///HydratedStorage provides a way to persist BLoC state by storing it in a local storage mechanism.
 ///Typically, this storage is on the device, such as in a file or SQLite database.

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

///This is the MyApp widget, which serves as the root of the application.
///It sets up a MultiBlocProvider to provide multiple BLoCs to its descendants.
///It uses a BlocBuilder to rebuild the UI based on changes in the SwitchBloc state.

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  /// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {

          ///Inside the MaterialApp, it sets up the title, theme, initial route (a splash screen in this case),
          ///and the route generator provided by appRouter.
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const SplashScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,

          );
        },
      ),
    );
  }
}
