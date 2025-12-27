import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iotproject/cubit/attendance_state.dart';
import 'package:iotproject/widget/Main_Action_Button.dart';
import '../cubit/attendance_cubit.dart';
import 'package:iotproject/services/Attendance_Service.dart';
import '../services/SessionService.dart';
import '../helper/show_snack_bar.dart';
import 'StudentsPage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late AttendanceCubit cubit;
  final SessionService _sessionService = SessionService();

  String? selectedWeek;
  final List<String> weeks = [
    'week 1',
    'week 2',
    'week 3',
    'week 4',
    'week 5',
    'week 6',
    'week 7',
    'week 8',
    'week 9',
    'week 10',
  ];

  @override
  void initState() {
    super.initState();
    cubit = AttendanceCubit(service: AttendanceService());

    _sessionService.getCurrentWeek().then((week) {
      setState(() {
        selectedWeek = week;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            "Attendance System",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(119, 93, 23, 154),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'lib/assets/image/steve-johnson-cm4U9PEtGWY-unsplash.png',
              ),
              fit: BoxFit.cover,
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (context, state) {
                final subjects = cubit.subjects;
                final selectedSessionId = cubit.selectedSessionId;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Welcome ',
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ),

                    DropdownButton<String>(
                      value: selectedSessionId,

                      dropdownColor: Colors.black,
                      iconEnabledColor: Colors.white,
                      items: subjects.entries
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.key,
                              child: Text(
                                e.value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) cubit.setSelectedSession(val);
                      },
                    ),

                    const SizedBox(height: 20),

                 
                    DropdownButton<String>(
                      value: selectedWeek,

                      dropdownColor: Colors.black,
                      iconEnabledColor: Colors.white,
                      items: weeks
                          .map(
                            (w) => DropdownMenuItem(
                              value: w,
                              child: Text(
                                w,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedWeek = val;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    
                    MainActionButton(
                      title: 'Open Attendance',
                      color: const Color.fromARGB(
                        255,
                        52,
                        16,
                        95,
                      ), 

                      onTap: () async {
                        if (cubit.selectedSessionId == null ||
                            selectedWeek == null)
                          return;
                        await _sessionService.openSession(
                          cubit.selectedSessionId!,
                          selectedWeek!,
                        );
                        showSnacbar(context, 'success Open');
                      },
                    ),

                    const SizedBox(height: 30),

                    /// قفل الحضور
                    MainActionButton(
                      title: 'Close Attendance',
                      color: const Color(
                        0xFF8B3A3A,
                      ), 

                      onTap: () async {
                        await _sessionService.closeSession();
                        showSnacbar(context, "success close");
                      },
                    ),

                    const SizedBox(height: 30),

                    
                    MainActionButton(
                      title: 'View Attendance',
                      color: const Color.fromARGB(
                        255,
                        9,
                        106,
                        98,
                      ), 
                      onTap: () async {
                        if (cubit.selectedSessionId == null) return;
                        await cubit.loadStudents(cubit.selectedSessionId!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentsPage(
                              students: cubit.students,
                              sessionId: cubit.selectedSessionId!,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 30),

                    
                    MainActionButton(
                      title: 'Remove To all Attendance ',
                      color: const Color.fromARGB(255, 134, 8, 141),
                      // أسود
                      onTap: () async {
                        if (cubit.selectedSessionId == null) return;
                        await cubit.clearStudents(cubit.selectedSessionId!);
                        showSnacbar(context, 'Remove To all');
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
