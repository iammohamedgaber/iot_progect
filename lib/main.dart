import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iotproject/views/login.dart';

import 'cubit/attendance_cubit.dart';

import 'package:iotproject/services/Attendance_Service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  

  runApp(const IotProject());
}

class IotProject extends StatelessWidget {
  const IotProject({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AttendanceCubit(service: AttendanceService()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
