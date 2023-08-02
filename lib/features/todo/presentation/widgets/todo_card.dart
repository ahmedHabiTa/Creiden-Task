import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/colors/colors.dart';
import '../../../core/constant/styles/styles.dart';

class TodoCard extends StatelessWidget {
  final NoteModel noteModel;
  const TodoCard({super.key, required this.noteModel});

  String getFormattedDate() {
    String dateStr = noteModel.date;
    DateTime dateTime = DateFormat('dd - MMMM - yyyy').parse(dateStr);
    String formattedDate = DateFormat('dd MMM').format(dateTime);
    return formattedDate;
  }

  String getFormattedTime() {
    String timeStr = noteModel.time;
    DateTime dateTime = DateFormat('hh:mm a').parse(timeStr);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 10),
      child: Container(
        height: 52.h,
        width: 320.w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 4),
              Container(
                height: 16.h,
                width: 16.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(int.parse(noteModel.color))),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Text(
                noteModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.textViewMedium15,
              )),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getFormattedDate(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textViewBold12.copyWith(color: mainColor),
                  ),
                  Text(
                    getFormattedTime(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.textViewRegular12
                        .copyWith(color: mainColor.withOpacity(0.6)),
                  )
                ],
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
