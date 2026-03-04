import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonLoader extends StatelessWidget {
  const PokemonLoader({super.key, this.size = 80});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinPerfect(
      infinite: true,
      child: SvgPicture.asset(
        'assets/images/loader.svg',
        width: size,
        height: size,
      ),
    );
  }
}
