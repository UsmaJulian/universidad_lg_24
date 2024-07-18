import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universidad_lg_24/Ranking/models/ranking_model.dart';
import 'package:universidad_lg_24/Ranking/ranking/ranking_bloc.dart';
import 'package:universidad_lg_24/Ranking/views/widgets/item_list_ranking_view.dart';
import 'package:universidad_lg_24/constants.dart';
import 'package:universidad_lg_24/users/models/models.dart';

class ContentRankingView extends StatefulWidget {
  const ContentRankingView({super.key, this.user});
  final User? user;
  @override
  State<StatefulWidget> createState() => _ContentRankingPage();
}

class _ContentRankingPage extends State<ContentRankingView> {
  @override
  void initState() {
    super.initState();

    getRankingData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<RankingBloc, RankingState>(
        builder: (context, state) {
          return SingleChildScrollView(
            // controller: scrollController,
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Text(
                          'RANKING',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.emoji_events,
                                color: Color(0xFFfbeb39),
                                size: 50,
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.emoji_events,
                                color: Color(0xFFe4e4e4),
                                size: 50,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Icon(
                                Icons.emoji_events,
                                color: Color(0xFFf8ac2f),
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is RankingSuccess)
                  for (final item in state.data.status!.data!)
                    ItemListRankingView(
                      item: item as Datum,
                    )
                else
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void getRankingData() {
    BlocProvider.of<RankingBloc>(context)
        .add(GetRanking(widget.user!.userId!, widget.user!.token!));
  }
}
