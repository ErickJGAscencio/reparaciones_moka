import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/core/entities/estado_equipo.dart';
import 'package:reparaciones_moka/core/entities/tipo_equipo.dart';
import 'package:reparaciones_moka/features/accesorios/presentation/providers/accesorios_provider.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 242, 248, 246),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Color(0xFF2F775A)),
                      ),
                      child: Text(
                        draft.tipoEquipo == null
                            ? "No hay tipo de equipo seleccionado"
                            : draft.tipoEquipo!.nombre,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F775A),
                      foregroundColor: Colors.white,
                    ),
                  onPressed: () async {
                    final tipoEquipo = await showModalBottomSheet<TipoEquipo>(
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
                    draft.tipoEquipo != null
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
                          'Estado del Equipo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChoiceChip(
                              label: const Text('Excelente'),
                              selected:
                                  ref
                                          .read(ordenFormProvider)
                                          .draft
                                          .estadoEquipo !=
                                      null
                                  ? ref
                                            .read(ordenFormProvider)
                                            .draft
                                            .estadoEquipo!
                                            .nombre ==
                                        "Excelente"
                                  : false,
                              onSelected: (selected) {
                                ref
                                    .read(ordenFormProvider.notifier)
                                    .updateEquipo(
                                      estadoEquipo: EstadoEquipo(
                                        id: 1,
                                        nombre: "Excelente",
                                      ),
                                    );
                              },
                            ),
                            SizedBox(width: 5),
                            ChoiceChip(
                              label: const Text('Aceptable'),
                              selected:
                                  ref
                                          .read(ordenFormProvider)
                                          .draft
                                          .estadoEquipo !=
                                      null
                                  ? ref
                                            .read(ordenFormProvider)
                                            .draft
                                            .estadoEquipo!
                                            .nombre ==
                                        "Aceptable"
                                  : false,
                              onSelected: (selected) {
                                ref
                                    .read(ordenFormProvider.notifier)
                                    .updateEquipo(
                                      estadoEquipo: EstadoEquipo(
                                        id: 2,
                                        nombre: "Aceptable",
                                      ),
                                    );
                              },
                            ),
                            SizedBox(width: 5),
                            ChoiceChip(
                              label: const Text('Dañado'),
                              selected:
                                  ref
                                          .read(ordenFormProvider)
                                          .draft
                                          .estadoEquipo !=
                                      null
                                  ? ref
                                            .read(ordenFormProvider)
                                            .draft
                                            .estadoEquipo!
                                            .nombre ==
                                        "Dañado"
                                  : false,
                              onSelected: (selected) {
                                ref
                                    .read(ordenFormProvider.notifier)
                                    .updateEquipo(
                                      estadoEquipo: EstadoEquipo(
                                        id: 3,
                                        nombre: "Dañado",
                                      ),
                                    );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
                          initialValue: ref.read(ordenFormProvider).draft.marca,
                          decoration: InputDecoration(
                            hintText: 'Marca',
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
                                .updateEquipo(marca: value);
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
                            hintText: 'Modelo',
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
                  hintText: 'No. de serie / IMEI',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Accesorios',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Consumer(
                          builder: (context, ref, _) {
                            final accesoriosState = ref.watch(
                              accesoriosProvider,
                            );
                            final ordenState = ref.watch(ordenFormProvider);

                            if (accesoriosState.accesorios.isEmpty) {
                              return const Center(
                                child: Text("No hay accesorios registrados"),
                              );
                            }

                            return Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: accesoriosState.accesorios.map((e) {
                                // Verificamos si el accesorio ya está seleccionado
                                final isSelected = ordenState.draft.accesorios
                                    .contains(e.nombre);

                                return ChoiceChip(
                                  label: Text(e.nombre),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    final notifier = ref.read(
                                      ordenFormProvider.notifier,
                                    );

                                    if (selected) {
                                      notifier.updateEquipo(
                                        accesorios: [
                                          ...(ordenState.draft.accesorios),
                                          e.nombre,
                                        ],
                                      );
                                    } else {
                                      notifier.updateEquipo(
                                        accesorios:
                                            (ordenState.draft.accesorios)
                                                .where(
                                                  (item) => item != e.nombre,
                                                )
                                                .toList(),
                                      );
                                    }
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
