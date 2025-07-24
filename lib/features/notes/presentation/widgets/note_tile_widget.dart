import 'package:fastnotes_bloc/core/utils/date_utils.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';

class NoteTileWidget extends StatelessWidget {
  const NoteTileWidget({super.key, required this.note});

  final NoteEntity? note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(note?.title ?? ''),
      subtitle: Text(note?.content ?? ''),
      trailing: Text(
        DateFormatUtils.formatDate(note?.createdAt ?? DateTime.now()),
      ),
    );
  }
}
