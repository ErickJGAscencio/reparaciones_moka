import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reparaciones_moka/features/auth/data/repositories/auth_repository.dart';
import 'package:reparaciones_moka/features/auth/data/services/auth_service.dart';
import 'package:reparaciones_moka/features/auth/domain/auth_use_case.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/pages/ordenes_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
 

  @override
  void dispose() {
 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 209, 228, 222),
      body: SafeArea(
        child: Center(
          child: Text('DashboardPage')
        ),
      ),
    );
  }
}
