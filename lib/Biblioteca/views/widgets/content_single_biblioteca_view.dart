import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/constants.dart';

class ContentSingleBibliotecaView extends StatefulWidget {
  const ContentSingleBibliotecaView({super.key, this.data});
  final BibliotecaValue? data;

  @override
  _ContentSingleBibliotecaViewState createState() =>
      _ContentSingleBibliotecaViewState();
}

class _ContentSingleBibliotecaViewState
    extends State<ContentSingleBibliotecaView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              widget.data!.title.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (widget.data!.fieldRecursosTipoValue.toString() ==
              'FieldRecursosTipoValue.VIDEO')
            SizedBox(
              height: MediaQuery.of(context).size.height - 400,
              width: double.infinity,
              child: HtmlWidget(
                '<iframe  width="${MediaQuery.of(context).size.width}" src="https://www.youtube.com/embed/${widget.data!.recurso}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>',
                customStylesBuilder: (element) {
                  if (element.classes.contains('iframe')) {
                    return {
                      'margin': '20px',
                      'padding': '20px',
                    };
                  }
                  return null;
                },
              ),
            )
          else
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              width: double.infinity,
              child: HtmlWidget(
                '<iframe height="${MediaQuery.of(context).size.height - 250} "  width="${MediaQuery.of(context).size.width}"+ src="https://docs.google.com/gview?url=https://107.178.247.254/sites/default/files/oralcom_lavadora_y_refrigeradora.pptx&embedded=true" frameborder="0" ></iframe>',
                customStylesBuilder: (element) {
                  if (element.classes.contains('iframe')) {
                    return {
                      'margin': '20px',
                      'padding': '20px',
                    };
                  }
                  return null;
                },
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              backgroundColor: mainColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
            child: const Text('Volver', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
