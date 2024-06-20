import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Entrenamiento/entrenamiento/entrenamiento_bloc.dart';
import 'package:universidad_lg_24/Entrenamiento/models/models.dart';
import 'package:universidad_lg_24/Entrenamiento/widgets/widgets.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class EntrenamientoContent extends StatefulWidget {
  const EntrenamientoContent({required this.user, super.key});
  final User user;
  @override
  _EntrenamientoContent createState() => _EntrenamientoContent();
}

class _EntrenamientoContent extends State<EntrenamientoContent> {
  EntrenamientoModel? entrenamientoInfo;
  bool load = false;
  EntrenamientoBloc entrenamientoBloc = EntrenamientoBloc();
  // int filtro = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  // void _changeFilter(value) {
  //   if (mounted) {
  //     setState(() {
  //       filtro = value;
  //     });
  //   }
  // }

  // void getFilterEntreteniminto({context, List<Filtro> data}) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           child: Wrap(
  //             children: <Widget>[
  //               for (var fil in data)
  //                 ListTile(
  //                     tileColor:
  //                         filtro == int.parse(fil.tid) ? mainColor : null,
  //                     title: Text(
  //                       fil.name,
  //                       style: TextStyle(
  //                           color: filtro == int.parse(fil.tid)
  //                               ? Colors.white
  //                               : null),
  //                     ),
  //                     onTap: () {
  //                       _changeFilter(int.parse(fil.tid));
  //                       Navigator.pop(context);
  //                     }),
  //             ],
  //           ),
  //         );
  //       });
  // }

  void loadData() {
    entrenamientoBloc
        .getEntrenamientoContent(
      token: widget.user.token,
      uid: widget.user.userId,
    )
        .then((EntrenamientoModel? value) {
      _onLoad();
      entrenamientoInfo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    if (load) {
      return SizedBox(
        // padding: EdgeInsets.all(0),
        child: EntrenamientoContentBody(
          user: widget.user,
          entrenamientoInfo: entrenamientoInfo,
          // filtro: filtro,
        ),
        // Positioned(
        //   bottom: 10.0,
        //   right: 10.0,
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       getFilterEntreteniminto(
        //           context: context, data: entrenamientoInfo.status.filtros);
        //     },
        //     child: const Icon(
        //       Icons.filter_alt,
        //     ),
        //     backgroundColor: mainColor,
        //   ),
        // )
      );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: mainColor,
      ),
    );
  }
}
