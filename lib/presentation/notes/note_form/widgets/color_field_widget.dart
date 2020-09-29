import 'package:ddd/application/notes/note_form_bloc/note_form_bloc.dart';
import 'package:ddd/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorField extends StatelessWidget {
  const ColorField();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteFormBloc, NoteFormState>(
        buildWhen: (p, c) => p.note.color != c.note.color,
        builder: (context, state) {
          return Container(
            height: 80,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final itemColor = NoteColor.predefinedColors[index];
                  return GestureDetector(
                    onTap: () {
                      context
                          .bloc<NoteFormBloc>()
                          .add(NoteFormEvent.colorChanged(itemColor));
                    },
                    child: Material(
                      elevation: 4 ,
                      shape: CircleBorder(
                        side: state.note.color.value.fold(
                            (l) => BorderSide.none,
                            (color) => color == itemColor
                                ? const BorderSide(width: 1.5)
                                : BorderSide.none),
                      ),
                      color: itemColor,
                      child: Container(
                        width: 70,
                        height: 70,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: NoteColor.predefinedColors.length),
          );
        });
  }
}
