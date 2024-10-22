import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:universidad_lg_24/Biblioteca/models/biblioteca_model.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/widgets/global/body_footer_global.dart';

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
    print(
      'src="https://docs.google.com/gview?url=${widget.data!.recurso}&embedded=true',
    );
    print('url:${widget.data!.recurso} ');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
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
            Expanded(
              child: (widget.data!.fieldRecursosTipoValue.toString() ==
                          'FieldRecursosTipoValue.VIDEO' &&
                      widget.data!.recurso != null &&
                      widget.data!.recurso!.isNotEmpty)
                  ? SingleChildScrollView(
                      child: HtmlWidget(
                        widget.data!.recurso.toString(),
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
                  //       : Expanded(
                  //           child: SingleChildScrollView(
                  //             child: HtmlWidget(
                  //               '<iframe height="${MediaQuery.of(context).size.height * 8}" width="${MediaQuery.of(context).size.width}" src="https://docs.google.com/gview?url=${widget.data!.recurso}&embedded=true" frameborder="0"></iframe>',
                  //               customStylesBuilder: (element) {
                  //                 if (element.classes.contains('iframe')) {
                  //                   return {
                  //                     'margin': '20px',
                  //                     'padding': '20px',
                  //                   };
                  //                 }
                  //                 return null;
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  : (widget.data!.recurso != null &&
                          widget.data!.recurso!.isNotEmpty &&
                          !widget.data!.recurso!.contains('null'))
                      ? CustomScrollView(
                          slivers: [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: HtmlWidget(
                                      '<iframe height="${MediaQuery.of(context).size.height * 8}" width="${MediaQuery.of(context).size.width}" src="https://docs.google.com/gview?url=${widget.data!.recurso}&embedded=true" frameborder="0"></iframe>',
                                      customStylesBuilder: (element) {
                                        if (element.classes
                                            .contains('iframe')) {
                                          return {
                                            'margin': '20px',
                                            'padding': '20px',
                                          };
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: Text('No hay contenido disponible'),
                        ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  backgroundColor: mainColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                child:
                    const Text('Volver', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const BodyFooter(),
          ],
        );
      },
    );
  }
}
