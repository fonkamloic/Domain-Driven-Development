import 'package:ddd/domain/notes/note_failure.dart';
import 'package:flutter/material.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;

  const CriticalFailureDisplay({Key key, @required this.failure})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            '😨',
            style: TextStyle(fontSize: 100),
          ),
          Text(
            failure.maybeMap(
              insufficientPermissions: (_) => "Insufficient permissions",
              orElse: () => 'unexpected error. \n Please contact support.',
            ),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () {
              print("Sending email..."); 
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.mail),
                SizedBox(width: 4),
                Text("I NEED HELP"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
