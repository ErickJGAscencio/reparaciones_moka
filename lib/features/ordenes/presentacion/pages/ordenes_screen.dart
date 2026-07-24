import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/auth/presentacion/providers/auth_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/orden_card.dart';
import 'package:reparaciones_moka/features/ordenes/data/services/ordenes_service.dart';

class OrdenesPage extends ConsumerStatefulWidget {
  const OrdenesPage({super.key});

  @override
  ConsumerState<OrdenesPage> createState() => _OrdenesPageState();
}

class _OrdenesPageState extends ConsumerState<OrdenesPage> {
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
    final authState = ref.read(authProvider);

    if (authState.session == null) throw Exception("No hay sesion, inicia sesión primero");    

    return await ordenesService.getOrdenes(authState.session!.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              return OrdenCard(orden: orden);
            },
          );
        },
      ),
    );
  }
}
