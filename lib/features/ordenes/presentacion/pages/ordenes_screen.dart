import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reparaciones_moka/features/ordenes/data/services/ordenes_service.dart';

class OrdenesPage extends StatefulWidget {
  const OrdenesPage({super.key});

  @override
  State<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends State<OrdenesPage> {
  late OrdenesService ordenesService;
  late Future<List<Map<String, dynamic>>> futureOrdenes;

  @override
  void initState() {
    super.initState();
    ordenesService = OrdenesService(
      Dio(BaseOptions(baseUrl: "http://10.0.2.2:8000")),
    );
    futureOrdenes = _cargarOrdenes();
  }

  Future<List<Map<String, dynamic>>> _cargarOrdenes() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("No hay token guardado, inicia sesión primero");
    }

    return await ordenesService.getOrdenes(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Órdenes"),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureOrdenes,
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
              return _buildCard(orden);
            },
          );
        },
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> orden) {
    final folio = orden["orden_id"].toString();
    final clienteNombre = orden["cliente"];
    final equipoInfo = orden['modelo'];
    final fecha = orden['fecha_ingreso'];
    final saldo = orden['saldo_a_pagar'];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        child: Column(
          children: [
            Text(folio),
            Text(clienteNombre["nombre"]),
            Text('$equipoInfo - $fecha'),
            Text('Saldo: $saldo'),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}