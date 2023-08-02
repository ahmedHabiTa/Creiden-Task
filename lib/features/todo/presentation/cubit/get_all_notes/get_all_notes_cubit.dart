import 'package:creiden/core/usecases/usecases.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/colors/colors.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/util/navigator.dart';
import '../../../../../local_notification.dart';
import '../../../domain/entities/note_model.dart';
import '../../../domain/usecases/get_all_notes.dart';

part 'get_all_notes_state.dart';

class GetAllNotesCubit extends Cubit<GetAllNotesState> {
  GetAllNotesCubit({required this.getAllNotesUsecase})
      : super(GetAllNotesInitial());

  final GetAllNotesUsecase getAllNotesUsecase;

  List<NoteModel> _noteList = [];
  List<NoteModel> get noteList => _noteList;

  List<NoteModel> _filteredList = [];
  List<NoteModel> get filteredList => _filteredList;

  Future<void> fReadAllNotes(context) async {
    emit(GetAllNotesLoading());
    final failOrUser = await getAllNotesUsecase(NoParams());
    failOrUser.fold((fail) {
      if (fail is NoteFailure) {
        emit(GetAllNotesError(message: fail.message));
      }
    }, (allNotesResponse) {
      _noteList = allNotesResponse;
      _filteredList = allNotesResponse;

      sendNoteNotification(context: context, noteList: _noteList);
      emit(GetAllNotesSuccess());
    });
  }

  String? selectedColor;
  changeColor({required Map<String, dynamic> value}) {
    selectedColor = value['hexColor'];
    emit(GetAllNotesInitial());
    emit(ChangeFilterNoteState());
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
    emit(GetAllNotesInitial());
    emit(ChangeFilterNoteState());
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
    emit(GetAllNotesInitial());
    emit(ChangeFilterNoteState());
  }

  fUpdateFilteredList(BuildContext context) {
    if (selectedColor == null &&
        _selectedDate == null &&
        timeController.text.isEmpty) {
      return;
    }
    if (selectedColor != null) {
      _filteredList =
          _noteList.where((element) => element.color == selectedColor).toList();
    }
    if (_selectedDate != null) {
      _filteredList = _noteList
          .where((element) => element.date == dateController.text)
          .toList();
    }
    if (timeController.text.isNotEmpty) {
      _filteredList = _noteList
          .where((element) => element.time == timeController.text)
          .toList();
    }

    AppNavigator.pop(context: context);
    emit(GetAllNotesInitial());
    emit(GetAllNotesSuccess());
  }

  resetFilter() {
    selectedColor = null;
    _selectedDate = null;
    dateController.clear();
    timeController.clear();
    _filteredList = _noteList;

    emit(GetAllNotesInitial());
    emit(GetAllNotesSuccess());
  }
}
