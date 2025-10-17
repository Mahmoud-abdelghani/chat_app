import 'package:chats/core/cubit/theme_cubit.dart';
import 'package:chats/core/database/cache_helper.dart';
import 'package:chats/core/utils/style/apptheme.dart';
import 'package:chats/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:chats/features/authentication/presentation/pages/login_view.dart';
import 'package:chats/features/authentication/presentation/pages/register_view.dart';
import 'package:chats/features/authentication/presentation/pages/verification_view.dart';
import 'package:chats/features/chat/presentation/cubit/messages_cubit.dart';
import 'package:chats/features/chat/presentation/pages/chat_view.dart';
import 'package:chats/features/home/presentation/cubit/chats_cubit.dart';
import 'package:chats/features/home/presentation/pages/home_view.dart';
import 'package:chats/features/onboard/presentation/pages/onboard_view.dart';
import 'package:chats/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chats/features/profile/presentation/pages/profile_view.dart';
import 'package:chats/features/profile/presentation/pages/update_text_view.dart';
import 'package:chats/features/profile/presentation/pages/update_view.dart';
import 'package:chats/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    Supabase.initialize(
      url: 'https://tbxfbpypnxvxofyjwtti.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRieGZicHlwbnh2eG9meWp3dHRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAxMTM5ODgsImV4cCI6MjA3NTY4OTk4OH0.kwPe1lg8O3hyjNtQ_gLGx78JzL2yKvAMd99oy8iXfSM',
    ),
  ]);
  await CacheHelper.init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationCubit()),
        BlocProvider(create: (context) => ChatsCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => MessagesCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              LoginView.routeName: (context) => LoginView(),
              RegisterView.routeName: (context) => RegisterView(),
              HomeView.routeName: (context) => HomeView(),
              VerificationView.routeName: (context) => VerificationView(),
              ProfileView.routeName: (context) => ProfileView(),

              UpdateView.routeName: (context) => UpdateView(),
              UpdateTextView.routeName: (context) => UpdateTextView(),
              OnboardView.routeName: (context) => OnboardView(),

              ChatView.routeName: (context) => ChatView(),
            },
            initialRoute: CacheHelper.getData("onboarded") == null
                ? OnboardView.routeName
                : FirebaseAuth.instance.currentUser == null
                ? LoginView.routeName
                : HomeView.routeName,
            theme: Apptheme.lightThem,
            themeMode: state,
            darkTheme: Apptheme.darkTheme,
          );
        },
      ),
    );
  }
}
//bimeiquacepra-9932@yopmail.com