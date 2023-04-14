import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nascon_security_app/core/app%20cubit/app_cubit.dart';
import 'package:nascon_security_app/core/app%20cubit/app_state.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_bloc.dart';
import 'package:nascon_security_app/features/auth/login/login_page.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/bloc/home_bloc.dart';
import 'package:nascon_security_app/features/home/barcode_scanner/home_page.dart';
import 'package:nascon_security_app/features/home/user%20details/bloc/user_details_bloc.dart';
import 'package:nascon_security_app/features/home/user%20details/user_details_page.dart';
import 'package:nascon_security_app/repos/auth_repo.dart';
import 'package:nascon_security_app/repos/home_repo.dart';

import 'core/go_router_refresh_stream.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    RepositoryProvider(
      create: (BuildContext context) => AuthRepo(),
      child: BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, color: Colors.black),
          headlineSmall: TextStyle(fontSize: 18, color: Colors.black),
          headlineMedium: TextStyle(fontSize: 20, color: Colors.black),
          headlineLarge: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
      routerConfig: _router,
    );
  }

  late final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (BuildContext context) => LoginBloc(
              authRepo: context.read<AuthRepo>(),
              appCubit: context.read<AppCubit>(),
            ),
            child: const LoginPage(),
          );
        },
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return RepositoryProvider(
            create: (BuildContext context) => HomeRepo(),
            child: BlocProvider(
              create: (BuildContext context) => HomeBloc(
                appCubit: context.read<AppCubit>(),
                homeRepo: context.read<HomeRepo>(),
              ),
              child: const HomePage(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: 'user_details',
            name: 'user_details',
            builder: (BuildContext context, GoRouterState state) {
              return RepositoryProvider(
                create: (BuildContext context) => HomeRepo(),
                child: BlocProvider(
                  create: (BuildContext context) => UserDetailsBloc(
                    appCubit: context.read<AppCubit>(),
                    homeRepo: context.read<HomeRepo>(),
                    id: state.queryParams['id']!,
                  ),
                  child: const UserDetailsPage(),
                ),
              );
            },
          ),
        ],
      ),
    ],
    redirect: (context, routerState) {
      log(routerState.location);
      log(context.read<AppCubit>().state.toString());

      if (context.read<AppCubit>().state is UnauthorizedAppState &&
          routerState.location != '/login') {
        return '/login';
      }
      if (context.read<AppCubit>().state is AuthorizedAppState &&
          routerState.location == '/login') {
        return '/';
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(context.watch<AppCubit>().stream),
  );
}
