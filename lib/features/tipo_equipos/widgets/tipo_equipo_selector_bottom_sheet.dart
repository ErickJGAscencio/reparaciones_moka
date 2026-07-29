import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_provider.dart';
import 'package:reparaciones_moka/features/tipo_equipos/presentation/providers/tipo_equipo_provider.dart';

class TipoEquipoSelectorBottomSheet extends ConsumerStatefulWidget {
  const TipoEquipoSelectorBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TipoEquipoSelectorBottomSheetState();
}

class _TipoEquipoSelectorBottomSheetState
    extends ConsumerState<TipoEquipoSelectorBottomSheet> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(tiposEquipoProvider.notifier).loadTiposEquipo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tiposEquipoProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,

      child: Column(
        children: [
          const SizedBox(height: 16),

          const Text(
            "Seleccionar Tipo de equipo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const Divider(),

          Expanded(
            child: Builder(
              builder: (_) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(child: Text(state.error!));
                }

                if (state.tiposEquipo.isEmpty) {
                  return const Center(child: Text("No hay tipos de equipo"));
                }

                return ListView.builder(
                  itemCount: state.tiposEquipo.length,
                  itemBuilder: (_, index) {
                    final cliente = state.tiposEquipo[index];

                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, cliente);
                      },
                      title: Text(cliente.nombre),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
