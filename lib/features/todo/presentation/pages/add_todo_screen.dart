// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/presentation/cubit/add_note/add_note_cubit.dart';
import 'package:creiden/features/todo/presentation/widgets/back_ground_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';
import '../widgets/add_edit_action_buttom.dart';

class AddTodoScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final NoteModel? noteModel;
  const AddTodoScreen({
    Key? key,
    required this.scaffoldKey,
    required this.noteModel,
  }) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final nameController = TextEditingController();

  final desController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorList = context.watch<AddNoteCubit>().colorList;
    return Form(
      key: formKey,
      child: BlocListener<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteSuccess) {
            desController.clear();
            nameController.clear();
            if (widget.scaffoldKey.currentState != null) {
              widget.scaffoldKey.currentState!.closeDrawer();
            }
          }
        },
        child: Scaffold(
          floatingActionButton: AddEditActionButtoms(
            noteModel: widget.noteModel,
            desController: desController,
            formKey: formKey,
            nameController: nameController,
            scaffoldKey: widget.scaffoldKey,
          ),
          body: BackgroundContainer(
            gradientList: addTodoGradient,
            child: SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Text(
                        'NEW TASK',
                        style: TextStyles.textViewRegular20
                            .copyWith(color: mainColor),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Color',
                        style: TextStyles.textViewRegular12
                            .copyWith(color: mainColor.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 5),
                      BlocBuilder<AddNoteCubit, AddNoteState>(
                        builder: (context, state) {
                          final selectedColor =
                              context.watch<AddNoteCubit>().selectedColor;
                          return Row(
                            children: List.generate(colorList.length, (index) {
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AddNoteCubit>()
                                        .changeColor(value: colorList[index]);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 28.h,
                                          width: 28.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorList[index]['color']),
                                        ),
                                        if (selectedColor != null &&
                                            selectedColor ==
                                                colorList[index]['hexColor'])
                                          const Icon(Icons.done_all,
                                              color: Colors.green),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Name',
                        style: TextStyles.textViewRegular12
                            .copyWith(color: mainColor.withOpacity(0.7)),
                      ),
                      Stack(
                        // mainAxisSize: MainAxisSize.min,
                        alignment: Alignment.bottomCenter,
                        children: [
                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value != null && value.trim().isEmpty) {
                                return "Name is Required...";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  blueColor.withOpacity(1),
                                  purpleColor.withOpacity(1)
                                ],
                                end: Alignment.centerRight,
                                begin: Alignment.centerLeft,
                                stops: const [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Description',
                        style: TextStyles.textViewRegular12
                            .copyWith(color: mainColor.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLines: 5,
                        controller: desController,
                        validator: (value) {
                          if (value != null && value.trim().isEmpty) {
                            return "Description is Required...";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: mainColor.withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: mainColor.withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: mainColor.withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: red,
                              width: 1,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: mainColor.withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Date',
                        style: TextStyles.textViewRegular12
                            .copyWith(color: mainColor.withOpacity(0.7)),
                      ),
                      BlocBuilder<AddNoteCubit, AddNoteState>(
                        builder: (context, state) {
                          final dateController =
                              context.watch<AddNoteCubit>().dateController;
                          return TextFormField(
                            controller: dateController,
                            onTap: () {
                              context.read<AddNoteCubit>().changeDate(context);
                            },
                            readOnly: true,
                            validator: (value) {
                              if (value != null && value.trim().isEmpty) {
                                return "Date is Required...";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: mainColor,
                            )),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Time',
                        style: TextStyles.textViewRegular12
                            .copyWith(color: mainColor.withOpacity(0.7)),
                      ),
                      BlocBuilder<AddNoteCubit, AddNoteState>(
                        builder: (context, state) {
                          final timeController =
                              context.watch<AddNoteCubit>().timeController;
                          return TextFormField(
                            controller: timeController,
                            readOnly: true,
                            onTap: () {
                              context.read<AddNoteCubit>().changeTime(context);
                            },
                            validator: (value) {
                              if (value != null && value.trim().isEmpty) {
                                return "Time is Required...";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                suffixIcon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: mainColor,
                            )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
