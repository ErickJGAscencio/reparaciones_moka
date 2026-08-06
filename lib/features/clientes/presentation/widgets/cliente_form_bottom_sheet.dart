import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reparaciones_moka/features/clientes/data/models/cliente_create_request.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_form_provider.dart';
import 'package:reparaciones_moka/features/clientes/presentation/providers/cliente_provider.dart';
import 'package:reparaciones_moka/features/ordenes/presentacion/providers/orden_form_provider.dart';

class ClienteFormBottomSheet extends ConsumerStatefulWidget {
  const ClienteFormBottomSheet({super.key});

  @override
  ConsumerState<ClienteFormBottomSheet> createState() =>
      _ClienteFormBottomSheetState();
}

class _ClienteFormBottomSheetState
    extends ConsumerState<ClienteFormBottomSheet> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(clientesProvider.notifier).loadClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ordenFormProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Registro de Cliente",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      ref.watch(ordenFormProvider.notifier).reset();
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.clear),
                  ),
                ],
              ),

              // Contenido
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: _buildContent(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Positioned(
                bottom: 0,
                child: Row(
                  children: [
                    if (state.currentStep > 0)
                      OutlinedButton(
                        onPressed: () {
                          ref.read(ordenFormProvider.notifier).previousStep();
                        },
                        child: const Text("Anterior"),
                      ),

                    const Spacer(),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F775A),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final clienteDraft = ref
                            .read(clienteFormProvider)
                            .draft;
                        ClienteCreateRequest orden =
                            ClienteCreateRequest.fromDraft(clienteDraft);

                        await ref
                            .read(clientesProvider.notifier)
                            .createCliente(orden);

                        Navigator.of(context).pop();
                      },
                      child: Text("Registrar Cliente"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final draft = ref.read(clienteFormProvider).draft;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          _buildInput(
            "Nombre",
            "Nombre del cliente",
            draft.nombre,
            (value) => ref
                .read(clienteFormProvider.notifier)
                .updateCliente(nombre: value),
          ),
          SizedBox(height: 10),
          _buildInput(
            "Número de teléfono",
            "ej. 0000000000",
            draft.telefono,
            (value) => ref
                .read(clienteFormProvider.notifier)
                .updateCliente(telefono: value),
          ),
          SizedBox(height: 10),
          _buildInput(
            "Correo",
            "ej. cliente@gmail.com",
            draft.correo,
            (value) => ref
                .read(clienteFormProvider.notifier)
                .updateCliente(correo: value),
          ),
          SizedBox(height: 10),
          _buildInput(
            "Dirección",
            "ej. En algún lugar",
            draft.direccion ?? "",
            (value) => ref
                .read(clienteFormProvider.notifier)
                .updateCliente(direccion: value),
          ),
          SizedBox(height: 10),
          _buildInput(
            "Notas",
            "ej. El mejor cliente del mundo",
            draft.notas ?? "",
            (value) => ref
                .read(clienteFormProvider.notifier)
                .updateCliente(notas: value),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    String hint,
    String initialValue,
    void Function(String value) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
