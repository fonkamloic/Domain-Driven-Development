import 'package:auto_route/auto_route.dart';
import 'package:ddd/application/auth/auth_bloc.dart';
import 'package:ddd/application/notes/note_actor_bloc/note_actor_bloc.dart';
import 'package:ddd/application/notes/note_watcher_bloc/note_watcher_bloc.dart';
import 'package:ddd/injections.dart';
import 'package:ddd/presentation/notes/notes_overview/widgets/notes_overview_body_widget.dart';
import 'package:ddd/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:ddd/presentation/routes/router.gr.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatcherBloc>(
          create: (context) => getIt<NoteWatcherBloc>()
            ..add(const NoteWatcherEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(
          create: (context) => getIt<NoteActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                  unauthenticated: (_) =>
                      ExtendedNavigator.of(context).replace(Routes.signInPage),
                  orElse: () {});
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                  deleteFailure: (state) {
                    FlushbarHelper.createError(
                            message: state.noteFailure.map(
                                unexpected: (_) =>
                                    "Unexpected error occured while deleting, please contact support",
                                insufficientPermissions: (_) =>
                                    "Insufficient permision ❌",
                                unableToUpdate: (_) => "Impossible error"),
                            duration: const Duration(seconds: 5))
                        .show(context);
                  },
                  orElse: () {});
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Notes"),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: <Widget>[
              UnCompletedSwitch(),
            ],
          ),
          body: NoteOverviewBodyWidget(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              ExtendedNavigator.of(context).pushNoteFormPage(editedNote: null);
            },
            child:const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
