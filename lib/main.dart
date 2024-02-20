import 'firebase_options.dart';
import 'Utils/routes/routs.dart';
import 'view_model/view_modal.dart';
import 'bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'view_model/user_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vacation_ownership_advisor/Screens/splashscreen.dart';
import 'package:vacation_ownership_advisor/view_model/tabs_view_model.dart';
import 'package:vacation_ownership_advisor/view_model/drop_down_view_model.dart';
import 'package:vacation_ownership_advisor/view_model/error_controll_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (context) => ConnectivityBloc(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthViewModal(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabsViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ErrorModelClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => DropDownViewModel(),
        )
      ],
      child: MaterialApp(
          onGenerateRoute: Routes.generateRoutes,
          title: 'Vacation Ownership Advisor',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF0092ff)),
            //useMaterial3: true,
          ),
          home: const CheckConnectivitySplashScreen()),
    );
  }
}
