import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app_bloc/Bloc/note_bloc.dart';
import 'package:flutter_note_app_bloc/Models/notes.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote({super.key});

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  String createdAt = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteBloc, NoteState>(
      listener: (context, state) {
        if (state is SuccessNoteUpdate) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if(state is GetNoteByIdState){
          title.text = state.notes.title;
          content.text = state.notes.content;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Note"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: (){
                  Navigator.of(context).pop();
                  context.read<NoteBloc>().add(GetAllNoteEvent());
                },
              ),
              actions: [
                state is LoadingState? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ) :  IconButton(
                    onPressed: () {
                      context.read<NoteBloc>().add(UpdateNoteEvent(
                          Notes(
                          noteId: state.notes.noteId,
                          title: title.text,
                          content: content.text,
                          createdAt: createdAt)));
                    },
                    icon: const Icon(Icons.check))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(hintText: "Title"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: content,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        hintText: "Content", border: InputBorder.none),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
