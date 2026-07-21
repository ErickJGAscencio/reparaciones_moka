import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reparaciones_moka/features/ordenes/data/services/ordenes_service.dart';

class OrdenesScreen extends StatefulWidget {
  const OrdenesScreen({super.key});

  @override
  State<OrdenesScreen> createState() => _OrdenesScreenState();
}

class _OrdenesScreenState extends State<OrdenesScreen> {
  late OrdenesService ordenesService;

  @override
  void initState() {
    super.initState();
    ordenesService = OrdenesService(
      Dio(BaseOptions(baseUrl: "http://10.0.2.2:8000")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Órdenes")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ordenesService.getOrdenes("TU_TOKEN_AQUI"), // token JWT
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final ordenes = snapshot.data ?? [];
          if (ordenes.isEmpty) {
            return const Center(child: Text("No hay órdenes"));
          }
          return ListView.builder(
            itemCount: ordenes.length,
            itemBuilder: (context, index) {
              final orden = ordenes[index];
              return ListTile(
                title: Text("Modelo: ${orden['modelo']}"),
                subtitle: Text("Falla: ${orden['falla_reporte']}"),
              );
            },
          );
        },
      ),
    );
  }
}
