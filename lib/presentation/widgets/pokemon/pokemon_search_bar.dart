import 'package:flutter/material.dart';

class PokemonSearchBar extends StatelessWidget {
  const PokemonSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.trailing,
    this.hintText,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? trailing;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final searchField = TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        hintText: hintText ?? 'Search Pokémon...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // filled: true,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: trailing != null
          ? Row(
              children: [
                Expanded(child: searchField),
                const SizedBox(width: 8),
                trailing!,
              ],
            )
          : searchField,
    );
  }
}
