import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_bloc/blocs/blocs.dart';
import 'package:first_bloc/constants/db_constants.dart';
import 'package:first_bloc/pages/user/home_page.dart';
import 'package:first_bloc/pages/authentication/signin_page.dart';
import 'package:first_bloc/pages/authentication/signup_page.dart';
import 'package:first_bloc/pages/authentication/splash_page.dart';
import 'package:first_bloc/repositories/auth_repository.dart';
import 'package:first_bloc/repositories/profile_repository.dart';
import 'package:first_bloc/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<TodoRepository>(
          create: (context) => TodoRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<TodoFilterBloc>(
            create: (context) => TodoFilterBloc(),
          ),
          BlocProvider<TodoSearchBloc>(
            create: (context) => TodoSearchBloc(),
          ),
          BlocProvider<TodoListBloc>(
            create: (context) => TodoListBloc(
              todoRepository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider<ActiveTodoCountBloc>(
            create: (context) => ActiveTodoCountBloc(
              initialActiveTodoCount:
                  context.read<TodoListBloc>().state.todos.length,
            ),
          ),
          BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
              initialTodos: context.read<TodoListBloc>().state.todos,
            ),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<FontSizeBloc>(
            create: (context) => FontSizeBloc(),
          ),
          BlocProvider<CardSizeBloc>(
            create: (context) => CardSizeBloc(
              fontSizeBloc: BlocProvider.of<FontSizeBloc>(context),
              initialFontSize: context.read<FontSizeBloc>().state.fontSize,
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            Color getThemeColor(bool isThemeLight) {
              if (isThemeLight) {
                return themeLightColor;
              } else {
                return themeDarkColor;
              }
            }

            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
              routes: {
                SignupPage.routeName: (context) => const SignupPage(),
                SigninPage.routeName: (context) => const SigninPage(),
                HomePage.routeName: (context) => const HomePage(),
              },
              theme: (state.isThemeLightSwitch == true
                      ? ThemeData.light()
                      : ThemeData.dark())
                  .copyWith(
                //scaffoldBackgroundColor: Colors.red,
                appBarTheme: AppBarTheme(
                  color: getThemeColor(state.isThemeLightSwitch),
                  iconTheme: IconThemeData(
                    color: getThemeColor(!state.isThemeLightSwitch),
                  ),
                ),
                cardTheme: CardTheme(
                  color: getThemeColor(state.isThemeLightSwitch),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    elevation: MaterialStateProperty.all(10),
                    backgroundColor: MaterialStateProperty.all(
                      getThemeColor(!state.isThemeLightSwitch),
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      getThemeColor(state.isThemeLightSwitch),
                    ),
                  ),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      getThemeColor(!state.isThemeLightSwitch),
                    ),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: getThemeColor(!state.isThemeLightSwitch),
                    ),
                  ),
                  filled: true,
                  floatingLabelStyle: TextStyle(
                    color: getThemeColor(!state.isThemeLightSwitch),
                  ),
                  iconColor: getThemeColor(!state.isThemeLightSwitch),
                ),
                textTheme: const TextTheme(
                  button: TextStyle(
                    fontSize: 20.0,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 21.0,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 18.0,
                  ),
                  headline5: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  headline6: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ).apply(
                  fontFamily: 'Righteous',
                  bodyColor: getThemeColor(!state.isThemeLightSwitch),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
