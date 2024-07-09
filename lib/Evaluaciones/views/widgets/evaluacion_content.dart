import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Evaluaciones/bloc/evaluacion_bloc.dart';
import 'package:universidad_lg_24/Evaluaciones/models/models.dart';
import 'package:universidad_lg_24/Evaluaciones/views/widgets/content_evaluacion.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class EvaluacionContent extends StatefulWidget {
  const EvaluacionContent({super.key, this.user});
  final User? user;
  @override
  _EvaluacionContent createState() => _EvaluacionContent();
}

class _EvaluacionContent extends State<EvaluacionContent> {
  Evaluacion? evaluacionInfo;
  bool load = false;
  EvaluacionBloc evalacioonBloc = EvaluacionBloc();

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    evalacioonBloc
        .getEvaluaionesContent(
      token: widget.user!.token,
      uid: widget.user!.userId,
    )
        .then((value) {
      _onLoad();
      evaluacionInfo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (load) {
      return RefreshIndicator(
        onRefresh: () async {
          load = false;
          loadData();
        },
        child: Container(
          // padding: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ContentEvaluacion(
                  evaluacionInfo: evaluacionInfo!.status!.evaluaciones,
                  user: widget.user,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
