import 'package:creiden/core/util/navigator.dart';
import 'package:creiden/features/todo/presentation/cubit/get_all_notes/get_all_notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../cubit/add_note/add_note_cubit.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorList = context.watch<AddNoteCubit>().colorList;
    return BlocBuilder<GetAllNotesCubit, GetAllNotesState>(
      builder: (context, state) {
        final selectedColor = context.watch<GetAllNotesCubit>().selectedColor;
        final dateController = context.watch<GetAllNotesCubit>().dateController;

        final timeController = context.watch<GetAllNotesCubit>().timeController;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                'Filters',
                style: TextStyles.textViewRegular16
                    .copyWith(color: mainColor.withOpacity(0.7)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(colorList.length, (index) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<GetAllNotesCubit>()
                          .changeColor(value: colorList[index]);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 28.h,
                            width: 28.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorList[index]['color']),
                          ),
                          if (selectedColor != null &&
                              selectedColor == colorList[index]['hexColor'])
                            const Icon(Icons.done_all, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              'Date',
              style: TextStyles.textViewRegular12
                  .copyWith(color: mainColor.withOpacity(0.7)),
            ),
            TextFormField(
              controller: dateController,
              onTap: () {
                context.read<GetAllNotesCubit>().changeDate(context);
              },
              readOnly: true,
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                Icons.arrow_drop_down_outlined,
                color: mainColor,
              )),
            ),
            const SizedBox(height: 20),
            Text(
              'Time',
              style: TextStyles.textViewRegular12
                  .copyWith(color: mainColor.withOpacity(0.7)),
            ),
            TextFormField(
              controller: timeController,
              readOnly: true,
              onTap: () {
                context.read<GetAllNotesCubit>().changeTime(context);
              },
              decoration: const InputDecoration(
                  suffixIcon: Icon(
                Icons.arrow_drop_down_outlined,
                color: mainColor,
              )),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    context
                        .read<GetAllNotesCubit>()
                        .fUpdateFilteredList(context);
                  },
                  icon: const Text('Filter'),
                ),
                IconButton(
                  onPressed: () {
                    context.read<GetAllNotesCubit>().resetFilter();
                    AppNavigator.pop(context: context);
                  },
                  icon: const Text('Clear'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
