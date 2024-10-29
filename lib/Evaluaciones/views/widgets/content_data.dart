import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/bloc/evaluacion_bloc.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/item_respuestas.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentData extends StatefulWidget {
  const ContentData({super.key, this.user, this.evaluacion});
  final User? user;
  final String? evaluacion;

  @override
  State<StatefulWidget> createState() => _ContentData();
}

class _ContentData extends State<ContentData> {
  RespuestaEvaluacion? data;
  EvaluacionBloc evalacionBloc = EvaluacionBloc();

  bool load = false;

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  Future<void> loadDataRespuesta() async {
    await evalacionBloc
        .getResultados(
      token: widget.user!.token,
      uid: widget.user!.userId,
      nid: widget.evaluacion.toString(),
    )
        .then((value) {
      _onLoad();
      data = value;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDataRespuesta();
  }

  @override
  Widget build(BuildContext context) {
    var cont = 1;

    if (load) {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              for (final item in data!.status!.respuetas!.items!)
                ItemRespuetas(item, cont++),
            ],
          ),
        ),
      );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    );
  }
}
