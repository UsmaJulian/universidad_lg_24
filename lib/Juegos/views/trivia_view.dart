import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universidad_lg_24/Juegos/models/juegos_content_model.dart';
// import 'package:universidad_lg_24/Juegos/services/juegos_services.dart';
import 'package:universidad_lg_24/Juegos/views/juegos_view.dart';
import 'package:universidad_lg_24/constants.dart';
// import 'package:universidad_lg_24/helpers/my_long_print.dart';
import 'package:universidad_lg_24/users/models/models.dart';
import 'package:universidad_lg_24/widgets/global/bottom_app_bar_global.dart';
import 'package:universidad_lg_24/widgets/global/header_global.dart';
import 'package:universidad_lg_24/widgets/widgets.dart';

class TriviaView extends StatefulWidget {
  const TriviaView({required this.user, required this.content, super.key});
  final User user;
  final JuegosContent content;
  @override
  State<TriviaView> createState() => _TriviaViewState();
}

class _TriviaViewState extends State<TriviaView> {
  int _currentTrivia = 0;
  final List<String> _currentAnswer = ['', '', '', '', ''];
  final _trivias = <dynamic>[];
  String _selectedAnswer = '';

  @override
  void initState() {
    _trivias.addAll(widget.content.body!.trivia!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Current: $_currentTrivia');
    return Scaffold(
      backgroundColor: const Color(0xffF6F3EB),
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: CustomAppBar(user: widget.user),
      endDrawer: DrawerMenu(
        user: widget.user,
        isHome: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 166, left: 38, right: 38, bottom: 121),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) {
                        return JuegosView(user: widget.user);
                      },
                      settings: const RouteSettings(name: '/games'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(129, 41),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    side: BorderSide(),
                  ),
                ),
                child: const Text(
                  'Volver',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const Text(
                'Trivia',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 43),
                child: Divider(
                  color: Color(0xff707070),
                  thickness: 1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Text(
                        '${_currentTrivia + 1}/${_trivias.length}',
                        style: const TextStyle(
                          color: Color(0xffAAA8A5),
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 6, left: 38, right: 38),
                      child: AutoSizeText(
                        maxLines: 4,
                        _trivias[_currentTrivia].question.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Divider(
                        color: Color(0xff707070),
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: List.generate(4, (index) {
                          final answer = _trivias[_currentTrivia].anwers[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedAnswer = (index + 1).toString();
                                  _currentAnswer[_currentTrivia] =
                                      _selectedAnswer;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(129, 41),
                                backgroundColor:
                                    _selectedAnswer == (index + 1).toString()
                                        ? Colors.green
                                        : const Color(0xffF6F3EB),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                              child: SizedBox(
                                width: 235,
                                child: AutoSizeText(
                                  answer.toString(),
                                  maxLines: 4,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 42,
                        left: 16,
                        bottom: 41,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_currentTrivia < _trivias.length - 1) {
                              _currentTrivia++;
                              _selectedAnswer = ''; // Reinicia el color
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(129, 41),
                          backgroundColor: mainColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                        child: Text(
                          (_currentTrivia == _trivias.length - 1)
                              ? 'Finalizar'
                              : 'Siguiente',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
