import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_bloc/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:first_bloc/cubits/auth/auth_bloc.dart';
import 'package:first_bloc/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:first_bloc/cubits/profile/profile_cubit.dart';
import 'package:first_bloc/cubits/signin/signin_cubit.dart';
import 'package:first_bloc/cubits/signup/signup_cubit.dart';
import 'package:first_bloc/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:first_bloc/cubits/todo_list/todo_list_cubit.dart';
import 'package:first_bloc/cubits/todo_search/todo_search_cubit.dart';
import 'package:first_bloc/pages/home_page.dart';
import 'package:first_bloc/pages/signin_page.dart';
import 'package:first_bloc/pages/signup_page.dart';
import 'package:first_bloc/pages/splash_page.dart';
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
          BlocProvider<TodoFilterCubit>(
            create: (context) => TodoFilterCubit(),
          ),
          BlocProvider<TodoSearchCubit>(
            create: (context) => TodoSearchCubit(),
          ),
          BlocProvider<TodoListCubit>(
            create: (context) => TodoListCubit(
              todoRepository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider<ActiveTodoCountCubit>(
            create: (context) => ActiveTodoCountCubit(
              initialActiveTodoCount:
                  context.read<TodoListCubit>().state.todos.length,
              todoListCubit: BlocProvider.of<TodoListCubit>(context),
            ),
          ),
          BlocProvider<FilteredTodosCubit>(
            create: (context) => FilteredTodosCubit(
              initialTodos: context.read<TodoListCubit>().state.todos,
              todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
              todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
              todoListCubit: BlocProvider.of<TodoListCubit>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          routes: {
            SignupPage.routeName: (context) => const SignupPage(),
            SigninPage.routeName: (context) => const SigninPage(),
            HomePage.routeName: (context) => const HomePage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
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
            ),
            fontFamily: 'WednesdayAdventure',
          ),
        ),
      ),
    );
  }
}
