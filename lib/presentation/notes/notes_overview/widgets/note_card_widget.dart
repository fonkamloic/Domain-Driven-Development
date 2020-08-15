import 'package:auto_route/auto_route.dart';
import 'package:ddd/application/notes/note_actor_bloc/note_actor_bloc.dart';
import 'package:ddd/domain/notes/note.dart';
import 'package:ddd/domain/notes/todo_item.dart';
import 'package:ddd/injections.dart';
import 'package:ddd/presentation/routes/router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key key, @required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onTap: () {
          ExtendedNavigator.of(context).pushNoteFormPage(editedNote: note);
        },
        onLongPress: () {
          final noteActorBloc = getIt<NoteActorBloc>();

          _showDeletionDialog(context, noteActorBloc);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Text(
              note.body.getOrCrash(),
              style: const TextStyle(fontSize: 18),
            ),
            if (note.todos.length > 0) ...[
              const SizedBox(height: 4),
              Wrap(spacing: 8, direction: Axis.horizontal, children: <Widget>[
                ...note.todos
                    .getOrCrash()
                    .map(
                      (todo) => TodoDisplay(
                        todoItem: todo as TodoItem,
                      ),
                    )
                    .iter,
              ])
            ]
            // Row(note.todos.getOrCrash().)
          ]),
        ),
      ),
    );
  }

  void _showDeletionDialog(BuildContext context, NoteActorBloc noteActorBloc) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected note:"),
            content: Text(note.body.getOrCrash(),
                maxLines: 3, overflow: TextOverflow.ellipsis),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("CANCEL"),
              ),
              FlatButton(
                  onPressed: () {
                    noteActorBloc.add(NoteActorEvent.deleted(note));
                    Navigator.pop(context);
                  },
                  child: const Text("DELETE"))
            ],
          );
        });
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todoItem;

  const TodoDisplay({Key key, @required this.todoItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      if (todoItem.done)
        Icon(
          Icons.check_box,
          color: Theme.of(context).accentColor,
        ),
      if (!todoItem.done)
        Icon(
          Icons.check_box_outline_blank,
          color: Theme.of(context).disabledColor,
        ),
      Text(todoItem.name.getOrCrash()),
    ]);
  }
}
