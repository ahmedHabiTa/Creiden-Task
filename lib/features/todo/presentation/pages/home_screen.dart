import 'package:creiden/features/todo/domain/entities/note_model.dart';
import 'package:creiden/features/todo/presentation/cubit/add_note/add_note_cubit.dart';
import 'package:creiden/features/todo/presentation/cubit/get_all_notes/get_all_notes_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../local_notification.dart';
import '../widgets/back_ground_container.dart';
import '../widgets/home_appbar.dart';
import '../widgets/todo_card.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  NoteModel? _noteModel;
  @override
  Widget build(BuildContext context) {
    return BlocListener<GetAllNotesCubit, GetAllNotesState>(
      listener: (context, state) {
        if (state is GetAllNotesSuccess) {
          sendNoteNotification(context: context);
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          width: 300.w,
          backgroundColor: const Color(0xff254dde),
          child: AddTodoScreen(
            scaffoldKey: scaffoldKey,
            noteModel: _noteModel,
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            setState(() {
              _noteModel = null;
            });
            if (scaffoldKey.currentState != null) {
              scaffoldKey.currentState!.openDrawer();
              context.read<AddNoteCubit>().resetParams();
            }
          },
          child: Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: LinearGradient(
                colors: buttomGradient,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: const Center(child: Icon(Icons.add, color: white)),
          ),
        ),
        body: BackgroundContainer(
          gradientList: homeBackgroudGradient,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              const HomeAppbar(),
              BlocBuilder<GetAllNotesCubit, GetAllNotesState>(
                builder: (context, state) {
                  final filteredList =
                      context.watch<GetAllNotesCubit>().filteredList;
                  return Expanded(
                    child: filteredList.isEmpty
                        ? const Center(child: Text('No Notes yet...'))
                        : ListView.builder(
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    if (scaffoldKey.currentState != null) {
                                      scaffoldKey.currentState!.openDrawer();
                                    }
                                    setState(() {
                                      _noteModel = filteredList[index];
                                    });
                                  },
                                  child:
                                      TodoCard(noteModel: filteredList[index]));
                            },
                          ),
                  );
                },
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
