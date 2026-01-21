import 'package:firebase_livescore/ad/AdBannerWidget.dart';
import 'package:firebase_livescore/commentary_tile.dart';
import 'package:firebase_livescore/match_score_card.dart';
import 'package:firebase_livescore/viewmodels/match_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiveScoreScreen extends StatelessWidget {
  final String matchId;

  const LiveScoreScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchViewModel(matchId: matchId),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: AdBannerWidget(),
          appBar: AppBar(title: const Text("CricDash Live")),
          body: Consumer<MatchViewModel>(
            builder: (context, viewModel, child) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: MatchScoreboardCard(viewModel: viewModel),
                  ),

                  const SliverPersistentHeader(
                    pinned: true,
                    delegate: _TabDelegate(),
                  ),

                  ListenableBuilder(
                    listenable: viewModel,
                    builder: (context, _) {
                      return SliverList.builder(
                        itemCount: viewModel.commentary.length,
                        itemBuilder: (context, index) => RepaintBoundary(
                          child: CommentaryTile(
                            ball: viewModel.commentary[index],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _TabDelegate extends SliverPersistentHeaderDelegate {
  const _TabDelegate();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      elevation: overlapsContent ? 4 : 0,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: const TabBar(
          tabs: [
            Tab(text: "COMMENTARY"),
            Tab(text: "SCORECARD"),
            Tab(text: "SQUADS"),
          ],
        ),
      ),
    );
  }

  // The height of the header when it is pinned
  @override
  double get maxExtent => 48.0;

  // The minimum height (usually the same as max for a simple tab bar)
  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
