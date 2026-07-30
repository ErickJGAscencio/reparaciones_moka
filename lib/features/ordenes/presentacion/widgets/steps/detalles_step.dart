import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';
import 'package:reparaciones_moka/features/tecnicos/data/models/user_model.dart';
import 'package:reparaciones_moka/features/tecnicos/presentation/widgets/users_selector_bottom_sheet.dart';

class DetallesStep extends ConsumerWidget {
  const DetallesStep({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Falla reportada por el cliente',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          initialValue: ref
                              .read(ordenFormProvider)
                              .draft
                              .fallaReporte,
                          maxLines: 3,
                          textAlign: TextAlign.start,

                          decoration: InputDecoration(
                            hintText: 'Describa el problema reportado',
                            alignLabelWithHint: true,
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
                                .updateDetalles(fallaReporte: value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Técnico asignado',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                draft.tecnicoAsignado == null
                    ? "No hay tipo de técnico seleccionado"
                    : draft.tecnicoAsignado!.nombre,
                style: Theme.of(context).textTheme.bodyLarge,
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
                    final tecnicoAsignado = await showModalBottomSheet<UserModel>(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      showDragHandle: true,
                      builder: (_) => const UsersSelectorBottomSheet(),
                    );
                    ref
                        .read(ordenFormProvider.notifier)
                        .updateDetalles(tecnicoAsignado: tecnicoAsignado);
                  },
                  child: Text(
                    draft.tecnicoAsignado != null
                        ? "Cambiar Técnico"
                        : "Asignar Técnico",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Costo estimado',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          initialValue:
                              ref.read(ordenFormProvider).draft.costo != 0.0
                              ? ref
                                    .read(ordenFormProvider)
                                    .draft
                                    .costo
                                    .toString()
                              : "",
                          decoration: InputDecoration(
                            hintText: '0.0',
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
                          'Anticipo',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          initialValue:
                              ref.read(ordenFormProvider).draft.costo != 0.0
                              ? ref
                                    .read(ordenFormProvider)
                                    .draft
                                    .costo
                                    .toString()
                              : "",
                          decoration: InputDecoration(
                            hintText: '0.0',
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
                'Al crear la orden se genera automáticamente la nota de recepción con folio y firma digital pendiente.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
