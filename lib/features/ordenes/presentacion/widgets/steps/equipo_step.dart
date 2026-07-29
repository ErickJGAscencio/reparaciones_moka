import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/estado_equipo.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';
import 'package:reparaciones_moka/features/tipo_equipos/widgets/tipo_equipo_selector_bottom_sheet.dart';

class EquipoStep extends ConsumerWidget {
  const EquipoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(ordenFormProvider).draft;

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo Equipo',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                draft.tipoEquipo == null
                    ? "No hay tipo de equipo seleccionado"
                    : draft.tipoEquipo!.nombre,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final tipoEquipo = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      showDragHandle: true,
                      builder: (_) => const TipoEquipoSelectorBottomSheet(),
                    );
                    ref
                        .read(ordenFormProvider.notifier)
                        .updateEquipo(tipoEquipo: tipoEquipo);
                  },
                  child: Text(
                    draft.cliente != null
                        ? "Cambiar Tipo"
                        : "Buscar Tipo de equipo",
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marca',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          initialValue: ref
                              .read(ordenFormProvider)
                              .draft
                              .modelo,
                          decoration: InputDecoration(
                            labelText: 'Marca',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(ordenFormProvider.notifier)
                                .updateEquipo(modelo: value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Modelo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          initialValue: ref
                              .read(ordenFormProvider)
                              .draft
                              .modelo,
                          decoration: InputDecoration(
                            labelText: 'Modelo',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(ordenFormProvider.notifier)
                                .updateEquipo(modelo: value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'No. de serie / IMEI',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                initialValue: ref.read(ordenFormProvider).draft.serie,
                decoration: InputDecoration(
                  labelText: 'No. de serie / IMEI',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onChanged: (value) {
                  ref
                      .read(ordenFormProvider.notifier)
                      .updateEquipo(serie: value);
                },
              ),
              const SizedBox(height: 6),
              Text(
                'Accesorios',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
