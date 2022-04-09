import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_bloc/blocs/blocs.dart';
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
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
              routes: {
                SignupPage.routeName: (context) => const SignupPage(),
                SigninPage.routeName: (context) => const SigninPage(),
                HomePage.routeName: (context) => const HomePage(),
              },
              theme: (state.isThemeLightSwitch == false
                      ? ThemeData.dark()
                      : ThemeData.light())
                  .copyWith(
                textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 100.0,
                    fontWeight: FontWeight.bold,
                  ),
                  headline6: TextStyle(
                    fontSize: 30.0,
                  ),
                  bodyText1: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyText2: TextStyle(
                    fontSize: 18.0,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  caption: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ).apply(
                  fontFamily: 'Righteous',
                  bodyColor: Colors.deepOrangeAccent,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
