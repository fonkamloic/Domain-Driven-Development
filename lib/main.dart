import 'package:ddd/application/simple_bloc_delegate.dart';
import 'package:ddd/injections.dart';
import 'package:ddd/presentation/core/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await configureInjection(Environment.prod);
 /** BlocDelegate allows us to override onTransition and onError and will help us see all bloc state changes (transitions) and errors in one place!
 */
  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();
  runApp(const AppWidget());
  // BlocSupervisor.delegate = SimpleBlocDelegate();
}
