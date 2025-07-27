import 'package:fastnotes_bloc/core/utils/date_utils.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteTileWidget extends StatelessWidget {
  const NoteTileWidget({super.key, required this.note, required this.onDelete});

  final NoteEntity? note;
  final Function(BuildContext context) onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: onDelete,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      child: ListTile(
        title: Text(note?.title ?? ''),
        subtitle: Text(note?.content ?? ''),
        trailing: Text(
          DateFormatUtils.formatDate(note?.createdAt ?? DateTime.now()),
        ),
      ),
    );
  }
}
