// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/constants.dart';
import 'package:flutter_pokedex/constants/ui_helper.dart';
import 'package:flutter_pokedex/model/pokemon_model.dart';

class PokeImageAndBall extends StatelessWidget {
  final PokemonModel pokemon;
  PokeImageAndBall({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Image.asset(
            Constants.pokemonImageUrl,
            width: UIHelper.calculatePokeImgAndBallSize(),
            height: UIHelper.calculatePokeImgAndBallSize(),
            fit: BoxFit.fitHeight,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Hero(
            tag: pokemon.id!,
            child: CachedNetworkImage(
                imageUrl: pokemon.img ?? 'N/A',
                errorWidget: (context, url, error) => const Icon(Icons.ac_unit),
                width: UIHelper.calculatePokeImgAndBallSize(),
                height: UIHelper.calculatePokeImgAndBallSize(),
                fit: BoxFit.fitHeight,
                placeholder: (context, url) => CircularProgressIndicator(
                      color: UIHelper.getColorFromType(pokemon.type![0]),
                    )),
          ),
        ),
      ],
    );
  }
}
