import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:ddd/domain/notes/i_note_repository.dart';
import 'package:ddd/domain/notes/note.dart';
import 'package:ddd/domain/notes/note_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:meta/meta.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

part 'note_watcher_bloc.freezed.dart';

@injectable
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  final INoteRepository _noteRepository;

  NoteWatcherBloc(this._noteRepository) : super(const NoteWatcherState.initial());

  StreamSubscription<Either<NoteFailure, KtList<Note>>> _noteStreamSubscription;

  @override
  Stream<NoteWatcherState> mapEventToState(
    NoteWatcherEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchAll().listen(
              (Either<NoteFailure, KtList<Note>> failureOrNotes) =>
                  add(NoteWatcherEvent.notesReceived(failureOrNotes)),
            );
      },
      watchUncompletedStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchUncompleted().listen(
              (Either<NoteFailure, KtList<Note>> failureOrNotes) =>
                  add(NoteWatcherEvent.notesReceived(failureOrNotes)),
            );
      },
      notesReceived: (e) async* {
        yield e.failureOrNotes.fold(
          (NoteFailure f) => NoteWatcherState.loadFailure(f),
          (KtList<Note> notes) => NoteWatcherState.loadSuccess(notes),
        );
      },
    );
  }

// close the subscription to firebase when not neither to avoid unneccessary bills.
  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }
}
