import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd/application/notes/note_form_bloc/note_form_bloc.dart';
import 'package:ddd/domain/notes/note.dart';
import 'package:ddd/injections.dart';
import 'package:ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:ddd/presentation/notes/note_form/widgets/add_todo_tile_widget.dart';
import 'package:ddd/presentation/notes/note_form/widgets/body_field_widget.dart';
import 'package:ddd/presentation/notes/note_form/widgets/color_field_widget.dart';
import 'package:ddd/presentation/notes/note_form/widgets/todo_list_widget.dart';
import 'package:ddd/presentation/routes/router.gr.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class NoteFormPage extends StatelessWidget {
  final Note editedNote;

  const NoteFormPage({Key key, @required this.editedNote}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NoteFormBloc>()
        ..add(NoteFormEvent.initialized(optionOf(editedNote))),
      child: BlocConsumer<NoteFormBloc, NoteFormState>(
        listenWhen: (p, c) =>
            p.saveFailureOrSuccessOption != c.saveFailureOrSuccessOption,
        listener: (context, state) {
          state.saveFailureOrSuccessOption.fold(
              () {},
              (either) => either.fold(
                      (failure) => FlushbarHelper.createError(
                            message: failure.map(
                              unexpected: (_) => 'An unexpected error occurred',
                              insufficientPermissions: (_) =>
                                  "You don\'t hav sufficient permissions. Contact support",
                              unableToUpdate: (_) => 'Unable to update note!',
                            ),
                          ).show(context), (r) {
                    ExtendedNavigator.of(context).popUntil((route) =>
                        route.settings.name == Routes.noteOverviewPage);
                  }));
        },
        buildWhen: (p, c) => p.isSaving != c.isSaving,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              NoteFormScaffold(),
              SavingsInProgressOverlay(isSaving: state.isSaving),
            ],
          );
        },
      ),
    );
  }
}

class SavingsInProgressOverlay extends StatelessWidget {
  final bool isSaving;
  const SavingsInProgressOverlay({
    Key key,
    @required this.isSaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return IgnorePointer(
      ignoring: !isSaving,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: isSaving ? Colors.black.withOpacity(0.8) : Colors.transparent,
        width: size.width,
        height: size.height,
        child: Visibility(
          visible: isSaving,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircularProgressIndicator(),
                const SizedBox(height: 8),
                Text(
                  'Savings',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white, fontSize: 16),
                )
              ]),
        ),
      ),
    );
  }
}

class NoteFormScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NoteFormBloc, NoteFormState>(
          buildWhen: (p, c) => p.isEditing != c.isEditing,
          builder: (context, state) =>
              Text(state.isEditing ? 'Edit a note' : 'Create a note'),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                context.bloc<NoteFormBloc>().add(const NoteFormEvent.saved());
              })
        ],
      ),
      body: BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (p, c) => p.showErrorMessage != c.showErrorMessage,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => FormTodos(),
                      child: Form(
              autovalidate: state.showErrorMessage,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const BodyField(),
                  const ColorField(),
                  const TodoList(),
                  const AddTodoTile(),
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
