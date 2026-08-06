import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';
import 'package:reparaciones_moka/features/tecnicos/data/models/user_model.dart';
import 'package:reparaciones_moka/features/tecnicos/presentation/widgets/users_selector_bottom_sheet.dart';
import 'package:signature/signature.dart';

class DetallesStep extends ConsumerStatefulWidget {
  const DetallesStep({super.key});

  @override
  ConsumerState<DetallesStep> createState() => _DetallesStepState();
}

class _DetallesStepState extends ConsumerState<DetallesStep> {
  late SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.green,
      exportBackgroundColor: Colors.transparent,
      exportPenColor: Colors.black,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(ordenFormProvider).draft;

    return SingleChildScrollView(
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      initialValue:
                          ref.read(ordenFormProvider).draft.costo != 0.0
                          ? ref.read(ordenFormProvider).draft.costo.toString()
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
                            .updateDetalles(costo: double.tryParse(value));
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      initialValue:
                          ref.read(ordenFormProvider).draft.anticipo != 0.0
                          ? ref
                                .read(ordenFormProvider)
                                .draft
                                .anticipo
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
                            .updateDetalles(anticipo: double.tryParse(value));
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

          const SizedBox(height: 20),
          Text(
            'Firma digital',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
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
                        backgroundColor: Colors.grey[300]!,
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _signatureController.clear();
                      },
                      child: const Text("Limpiar"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Guardar"),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2F775A),
              foregroundColor: Colors.white,
            ),
            child: const Text("Abrir firma"),
          ),
          Text(
            _signatureController.isEmpty
                ? "Sin firma registrada"
                : "Firma capturada",
          ),
        ],
      ),
    );
  }
}
