import 'package:ddd/application/notes/note_form_bloc/note_form_bloc.dart';
import 'package:ddd/presentation/notes/note_form/misc/todo_item_presentation_classes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:ddd/presentation/notes/note_form/misc/build_context_x.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => c.isEditing != p.isEditing,
      listener: (context, state) {
        context.formTodos = state.note.todos.value.fold(
            (f) => listOf<TodoItemPrimitive>(),
            (todoItemList) =>
                todoItemList.map((_) => TodoItemPrimitive.fromDomain(_)));
      },
      buildWhen: (p, c) => p.note.todos.isFull != c.note.todos.isFull,
      builder: (context, state) {
        return ListTile(
          enabled: !state.note.todos.isFull,
          title: const Text("Add a todo"),
          leading: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.add),
          ),
          onTap: () {
            context.formTodos =
                context.formTodos.plusElement(TodoItemPrimitive.empty());
            context
                .bloc<NoteFormBloc>()
                .add(NoteFormEvent.todosChanged(context.formTodos));
          },
        );
      },
    );
  }
}
