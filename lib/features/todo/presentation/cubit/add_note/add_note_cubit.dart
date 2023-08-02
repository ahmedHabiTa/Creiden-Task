import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:creiden/features/core/constant/colors/colors.dart';
import 'package:creiden/features/todo/domain/usecases/add_note.dart';
import 'package:creiden/features/todo/presentation/cubit/get_all_notes/get_all_notes_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/widgets/show_toast.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit({required this.addNoteUsecase}) : super(AddNoteInitial());

  final AddNoteUsecase addNoteUsecase;

  Future<void> fAddNote({
    required String name,
    required String description,
    required GlobalKey<FormState> formKey,
  }) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (selectedColor == null) {
      showToastError('Color is Required...');
      return;
    }
    emit(AddNoteLoading());
    final failOrUser = await addNoteUsecase(AddNoteParams(
      id: Random().nextInt(4),
      name: name,
      description: description,
      color: selectedColor!,
      date: dateController.text,
      time: timeController.text,
    ));
    failOrUser.fold((fail) {
      if (fail is NoteFailure) {
        emit(AddNoteError(message: fail.message));
      }
    }, (allNotesResponse) {
      sl<GetAllNotesCubit>().fReadAllNotes();
      resetParams();

      emit(AddNoteSuccess());
    });
  }

  List<Map<String, dynamic>> colorList = [
    {'color': const Color(0xffcf28a9), 'hexColor': '0xffcf28a9'},
    {'color': const Color(0xff0dc4f4), 'hexColor': '0xff0dc4f4'},
    {'color': purpleColor, 'hexColor': '0xffff008d'},
    {'color': mainColor, 'hexColor': '0xff181743'},
    {'color': const Color(0xff00cf1c), 'hexColor': '0xff00cf1c'},
    {'color': const Color(0xffffee00), 'hexColor': '0xffffee00'},
  ];

  String? selectedColor;
  changeColor({required Map<String, dynamic> value}) {
    selectedColor = value['hexColor'];
    emit(AddNoteInitial());
    emit(ChangeAddNoteState());
  }

  DateTime? _selectedDate;
  TextEditingController dateController = TextEditingController();
  changeDate(context) async {
    _selectedDate = await showDatePicker(
      context: context,
      // initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale("en"),
      lastDate: DateTime(2050),
      builder: (context, child) => Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: mainColor,
              onPrimary: white,
              onSurface: blackColor,
            ),
          ),
          child: child ?? const SizedBox()),
    );
    if (_selectedDate != null) {
      dateController.text =
          DateFormat("dd - MMMM - yyyy").format(_selectedDate!);
    }
    emit(AddNoteInitial());
    emit(ChangeAddNoteState());
  }

  TextEditingController timeController = TextEditingController();

  changeTime(context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      timeController.text =
          '${newTime.hourOfPeriod}:${newTime.minute.toString().padLeft(2, '0')} ${newTime.period == DayPeriod.am ? 'AM' : 'PM'}';
    }
    emit(AddNoteInitial());
    emit(ChangeAddNoteState());
  }

  resetParams() {
    selectedColor = null;
    timeController.clear();
    dateController.clear();
    emit(AddNoteInitial());
    emit(ChangeAddNoteState());
  }
}
