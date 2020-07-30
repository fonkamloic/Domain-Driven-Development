import 'package:auto_route/auto_route.dart';
import 'package:ddd/application/auth/auth_bloc.dart';
import 'package:ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:ddd/presentation/routes/router.gr.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold((failure) {
                  FlushbarHelper.createError(
                    message: failure.map(
                        cancelledByUser: (_) => 'Canncelled',
                        serverError: (_) => 'Server Error',
                        emailAlreadyInUse: (_) => 'Email already in user',
                        invalidEmailAndPasswordCombination: (_) =>
                            'Invalid password and email combination'),
                  );
                }, (r) {
                  ExtendedNavigator.of(context)
                      .pushReplacementNamed(Routes.noteOverviewPage);
                      context.bloc<AuthBloc>().add(const AuthEvent.authCheckRequested());
                }));

        // state.authFailureOrSuccessOption.fold(() {}, (either) => either.fold((failure) {} , (r) { // navigate }));
      },
      builder: (context, state) {
        return Form(
          autovalidate: state.showErrorMessages,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              const Text(
                ' 🗒 ',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 130),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                ),
                autocorrect: false,
                onChanged: (value) => context
                    .bloc<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context
                    .bloc<SignInFormBloc>()
                    .state
                    .password
                    .value
                    .fold(
                        (f) => f.maybeMap(
                            invalidEmail: (_) => "Invalid Email",
                            orElse: () => null),
                        (r) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                obscureText: true,
                autocorrect: false,
                onChanged: (value) => context
                    .bloc<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => context
                    .bloc<SignInFormBloc>()
                    .state
                    .password
                    .value
                    .fold(
                        (f) => f.maybeMap(
                            shortPassword: (_) => "Short Password",
                            orElse: () => null),
                        (r) => null),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: FlatButton(
                    onPressed: () {
                      context.bloc<SignInFormBloc>().add(const SignInFormEvent
                          .signInWithEmailAndPasswordPressed());
                    },
                    child: const Text("SIGN IN"),
                  )),
                  Expanded(
                      child: FlatButton(
                    onPressed: () {
                      context.bloc<SignInFormBloc>().add(const SignInFormEvent
                          .registerWithEmailAndPasswordPressed());
                    },
                    child: const Text("REGISTER"),
                  )),
                ],
              ),
              RaisedButton(
                onPressed: () {
                  context
                      .bloc<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressed());
                },
                color: Colors.lightBlue,
                child: const Text("SIGN IN WITH GOOGLE",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              if (state.isSubmitting) ...[
                const SizedBox(height: 8),
                const LinearProgressIndicator(value: null),
              ]
            ],
          ),
        );
      },
    );
  }
}
