import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/blocs/perfil/perfil_bloc.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/users/views/profile/widgets/widgets.dart';

class ContentPerfilView extends StatefulWidget {
  const ContentPerfilView({super.key, this.user});
  final User? user;

  @override
  _ContentPerfilViewState createState() => _ContentPerfilViewState();
}

class _ContentPerfilViewState extends State<ContentPerfilView> {
  Perfil? data;
  @override
  void initState() {
    super.initState();

    _getPerfil();
  }

  void _showResponse(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: mainColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocListener<PerfilBloc, PerfilState>(
        listener: (context, state) {
          if (state is PerfilSend) {
            _showResponse(state.message);
          }
          if (state is ErrorPerfil) {
            _showResponse(state.message);
          }
        },
        child: BlocBuilder<PerfilBloc, PerfilState>(
          builder: (context, state) {
            if (state is PerfilSuccess) {
              data = state.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    BannerPerfil(imagen: state.data.status!.data!.imagen),
                    ContentBody(
                      user: widget.user,
                      totalpuntos: state.data.status!.data!.totalpuntos,
                      oro: state.data.status!.data!.oro,
                      plata: state.data.status!.data!.plata,
                      bronce: state.data.status!.data!.bronce,
                    ),
                  ],
                ),
              );
            }

            if (state is ChangeImage) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    BannerPerfil(imagen: data!.status!.data!.imagen),
                    ContentBody(
                      user: widget.user,
                      totalpuntos: data!.status!.data!.totalpuntos,
                      oro: data!.status!.data!.oro,
                      plata: data!.status!.data!.plata,
                      bronce: data!.status!.data!.bronce,
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: mainColor,
              ),
            );
          },
        ),
      ),
    );
  }

  void _getPerfil() {
    BlocProvider.of<PerfilBloc>(context).add(
      GetPerfilEvent(user: widget.user!.userId, token: widget.user!.token),
    );
  }
}
