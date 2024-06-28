import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/perfil/perfil_bloc.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class BannerPerfil extends StatefulWidget {
  const BannerPerfil({super.key, this.imagen});
  final String? imagen;

  @override
  _BannerPerfilState createState() => _BannerPerfilState();
}

class _BannerPerfilState extends State<BannerPerfil> {
  final _picker = ImagePicker();
  String? img;
  bool change = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundImage(
            image: 'assets/images/back-perfil.png',
          ),
          if (change == false)
            InkWell(
              onTap: choose,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: CachedNetworkImage(
                  imageUrl: widget.imagen.toString(),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: mainColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            )
          else
            InkWell(
              onTap: choose,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.file(File(img.toString())),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> choose() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        img = image.path;
        change = true;
      });

      final List<int> imageBytes = await image.readAsBytes();
      await Future<void>.delayed(Duration.zero).then(
        (_) => BlocProvider.of<PerfilBloc>(context)
            .add(SetImagePerfilEvent(base64Encode(imageBytes))),
      );
    }
  }
}
