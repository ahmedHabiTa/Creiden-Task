// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/presentation/cubit/delete_note/delete_note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../cubit/add_note/add_note_cubit.dart';

// ignore: must_be_immutable
class AddEditActionButtoms extends StatefulWidget {
  final NoteModel? noteModel;
  final GlobalKey<FormState> formKey;
  TextEditingController nameController;
  TextEditingController desController;

  final GlobalKey<ScaffoldState> scaffoldKey;

  AddEditActionButtoms({
    Key? key,
    required this.noteModel,
    required this.formKey,
    required this.nameController,
    required this.desController,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  State<AddEditActionButtoms> createState() => _AddEditActionButtomsState();
}

class _AddEditActionButtomsState extends State<AddEditActionButtoms> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (widget.noteModel != null) {
        context.read<AddNoteCubit>().initParams(noteModel: widget.noteModel!);
        widget.nameController.text = widget.noteModel!.name;
        widget.desController.text = widget.noteModel!.description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.noteModel == null
        ? GestureDetector(
            onTap: () {
              context.read<AddNoteCubit>().fAddNote(
                    formKey: widget.formKey,
                    name: widget.nameController.text.trim(),
                    description: widget.desController.text.trim(),
                    context: context,
                  );
            },
            child: Container(
              height: 46.h,
              width: 132.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  colors: buttomGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Center(
                  child: Text(
                'Add',
                style: TextStyles.textViewRegular16.copyWith(color: white),
              )),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context.read<AddNoteCubit>().fUpdateNote(
                      noteModel: widget.noteModel!,
                      formKey: widget.formKey,
                      name: widget.nameController.text.trim(),
                      description: widget.desController.text.trim(),
                      context: context);
                },
                child: Container(
                  height: 46.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: LinearGradient(
                      colors: buttomGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    'Update',
                    style: TextStyles.textViewRegular16.copyWith(color: white),
                  )),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  context
                      .read<DeleteNoteCubit>()
                      .fDeleteNote(id: widget.noteModel!.id, context: context);
                  if (widget.scaffoldKey.currentState != null) {
                    widget.scaffoldKey.currentState!.closeDrawer();
                  }
                },
                child: Container(
                  height: 46.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Center(
                      child: Text(
                    'Delete',
                    style: TextStyles.textViewRegular16.copyWith(color: white),
                  )),
                ),
              ),
            ],
          );
  }
}
