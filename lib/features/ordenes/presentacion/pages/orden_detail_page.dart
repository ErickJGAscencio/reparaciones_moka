import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/domain/entities/orden.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/ordenes_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/widgets/views/information_view.dart';
import 'package:signature/signature.dart';

class OrdenDetailPage extends ConsumerStatefulWidget {
  final int id;
  const OrdenDetailPage({super.key, required this.id});

  @override
  ConsumerState<OrdenDetailPage> createState() => _OrdenDetailPageState();
}

class _OrdenDetailPageState extends ConsumerState<OrdenDetailPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    strokeCap: StrokeCap.butt,
    strokeJoin: StrokeJoin.miter,
    penColor: Colors.green,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    // onDrawStart: () => ,
    // onDrawEnd: () => ,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _signatureController
      ..addListener(() => ())
      ..onDrawEnd = () => setState(() {});

    Future.microtask(() {
      ref.read(ordenesProvider.notifier).loadOrdenById(widget.id);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  Widget _statusPill(String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F775A)),
      ),
    );
  }

  Widget _infoRow(String tag, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tag, style: Theme.of(context).textTheme.bodyLarge),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _infoRowColumn(String tag, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ],
    );
  }

  Widget _noteView(Orden orden) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person,
                    color: const Color.fromARGB(255, 56, 122, 59),
                    size: 40,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'MOKA',
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(),
                            ),
                            Text(
                              'Nota de recepción',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: const Color.fromARGB(
                                      255,
                                      97,
                                      97,
                                      97,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              orden.id.toString(),
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(),
                            ),
                            Text(
                              orden.fechaIngreso.toIso8601String(),
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: const Color.fromARGB(
                                      255,
                                      97,
                                      97,
                                      97,
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(),
              _infoRow("Nombre", orden.cliente.nombre),
              Divider(),
              _infoRow("Equipo", "${orden.marca} - ${orden.modelo}"),
              Divider(),
              _infoRow("Técnico asignado", orden.tecnico!.nombre),
              Divider(),
              _infoRowColumn(
                "ESTADO DEL EQUIPO (RECEPCIÓN)",
                orden.estadoEquipo.nombre,
              ),
              _infoRowColumn("FALLA REPORTADA", orden.fallaReporte),
              _infoRowColumn("accesorios recibidos", orden.accesorios),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Costo',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '\$${orden.costo.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Anticipo',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '${orden.anticipo > 0 ? "\$" + orden.anticipo.toStringAsFixed(2) : "Sin anticipo"}',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saldo pendiente',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '${orden.saldoPendiente > 0 ? "\$" + orden.saldoPendiente.toStringAsFixed(2) : "Sin saldo pendiente"}',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //SIGNATURE CANVAS PARA INTEGRAR LA FIRMA ABRIR EN PANTALLA COMPLETA
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Signature(
                  placeholder: Text(
                    'Sign here',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: Colors.red),
                  ),
                  key: const Key('signature'),
                  controller: _signatureController,
                  height: 300,
                  backgroundColor: Colors.grey[300]!,
                ),
              ),
              Text(
                _signatureController.isEmpty
                    ? "Signature pad is empty"
                    : "Signature pad is not empty",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackView() {
    final eventos = [
      {
        "titulo": "Equipo recibido",
        "fecha": "02 Jul 2026",
        "detalle": "Recepción por Luis Montiel",
      },
      {
        "titulo": "Equipo en revisión",
        "fecha": "03 Jul 2026",
        "detalle": "Revisión por Ana Pérez",
      },
      {
        "titulo": "Reparación en curso",
        "fecha": "05 Jul 2026",
        "detalle": "Reparación por Carlos Díaz",
      },
      {
        "titulo": "Listo para entrega",
        "fecha": "05 Jul 2026",
        "detalle": "Reparación por Carlos Díaz",
      },
      {
        "titulo": "Entragado",
        "fecha": "05 Jul 2026",
        "detalle": "Reparación por Carlos Díaz",
      },
    ];

    return Expanded(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bitácora de actividad",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Column(
                children: List.generate(eventos.length, (index) {
                  final evento = eventos[index];
                  final esUltimo = index == eventos.length - 1;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: const Color(0xFF224D23),
                          ),
                          if (!esUltimo)
                            Container(
                              width: 2.5,
                              height: 40,
                              color: const Color.fromARGB(255, 190, 190, 190),
                            ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(evento["titulo"]!),
                            Text(evento["fecha"]!),
                            Text(evento["detalle"]!),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              ElevatedButton(onPressed: () {}, child: Text("Avanzar paso")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordenesProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
    }

    if (state.selectedOrden == null) {
      return const Center(child: Text("No se encontró la orden"));
    }

    final orden = state.selectedOrden!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orden #${orden.id}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Color(0xFF2F775A)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orden.id}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      orden.cliente.nombre,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${orden.marca} ${orden.modelo}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                _statusPill(orden.estadoReparacion.nombre),
              ],
            ),
          ),

          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Información'),
              Tab(text: 'Nota Recep.'),
              Tab(text: 'Seguimiento'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                InformationView(orden: orden,),
                _noteView(orden),
                _trackView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
