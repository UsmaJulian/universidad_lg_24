import 'package:flutter/material.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/home/blocs/homebloc/home_bloc.dart';
import 'package:universidad_lg_24/home/models/models.dart';
import 'package:universidad_lg_24/home/widgets/widgets.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key, this.user});
  final User? user;
  @override
  _HomeContent createState() => _HomeContent();
}

class _HomeContent extends State<HomeContent> {
  // static final String oneSignalAppId = "a1ea5f8a-4412-4e90-8fd0-8ac42aa31921";
  HomeModel? homeInfo;
  bool load = false;
  HomeBloc homeBloc = HomeBloc();

  void _onLoad() {
    if (mounted) {
      setState(() {
        load = true;
      });
    }
  }

  void _loader() {
    homeBloc
        .getHomeContent(token: widget.user!.token, uid: widget.user!.userId)
        .then((HomeModel? value) {
      _onLoad();
      homeInfo = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loader();
    initPlatformState();
    print('fff');
  }

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    if (load) {
      return Container(
        // padding: EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarrucelHome(homeInfo!.status?.carrucel),
              // _CalendarioHome(),
              NoticiasHome(homeInfo!.status?.noticias, widget.user),
              ConoceMas(user: widget.user),
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

  Future<void> initPlatformState() async {
    if (!mounted) return;
    /*  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setAppId('a1ea5f8a-4412-4e90-8fd0-8ac42aa31921');

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      final String tipoRespuesta = result.notification.additionalData['type'];

      if (tipoRespuesta.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (tipoRespuesta == 'curso') {
                final id = result.notification.additionalData['nid'].toString();
                return CursoPreviewPage(user: widget.user, nid: id);
              }
              if (tipoRespuesta == 'evaluacion') {
                return EvaluacionPage(user: widget.user);
              }
              if (tipoRespuesta == 'biblioteca') {
                return BibliotecaPage(
                  user: widget.user,
                );
              }
              return null;
            },
          ),
        );
      }
    }); */

    //   OneSignal.shared.init(
    //     oneSignalAppId,
    //   );

    //   OneSignal.shared
    //       .setInFocusDisplayType(OSNotificationDisplayType.notification);

    //   OneSignal.shared.setNotificationOpenedHandler((openedResult) {
    //     var data = openedResult.notification.payload.additionalData;

    //     Navigator.push(context, MaterialPageRoute(builder: (context) {
    //       // print(data);

    //       return null;
    //     }));
    //   });
  }
}
