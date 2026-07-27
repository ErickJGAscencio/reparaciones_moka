import 'package:flutter/material.dart';
import 'package:reparaciones_moka/core/widgets/search_selector.dart/search_selector.dart';

class ClienteStep extends StatelessWidget {
  const ClienteStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Paso 1 - Cliente"),
          ElevatedButton(
            onPressed: () async {
              await showSearchSelector<String>(
                context: context,
                title: "Buscar cliente",
                onSearch: (_) async {
                  return [];
                },
                itemBuilder: (item) {
                  return ListTile(title: Text(item));
                },
              );
            },
            child: const Text("Buscar Cliente"),
          ),
        ],
      ),
    );
  }
}
