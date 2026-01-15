import 'package:firebase_livescore/commentary_tile.dart';
import 'package:firebase_livescore/match_score_card.dart';
import 'package:firebase_livescore/viewmodels/match_viewmodel.dart';
import 'package:flutter/material.dart';

class LiveScoreScreen extends StatelessWidget {
  final MatchViewModel viewModel;

  const LiveScoreScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text("CricDash Live")),
        body: CustomScrollView(
          slivers: [
            // 1. The Dynamic Score Header
            SliverToBoxAdapter(
              child: MatchScoreboardCard(viewModel: viewModel),
            ),

            // 2. Sticky Tab Bar (Scorecard / Commentary / Stats)
            const SliverPersistentHeader(
              pinned: true,
              delegate: _TabDelegate(),
            ),

            // 3. The Commentary List
            ListenableBuilder(
              listenable: viewModel,
              builder: (context, _) {
                return SliverList.builder(
                  itemCount: viewModel.commentary.length,
                  itemBuilder: (context, index) => RepaintBoundary(
                    child: CommentaryTile(ball: viewModel.commentary[index]),
                  ),
                );
              },
            ),
          ],
        ),
        //bottomNavigationBar: const MyBannerAdWidget(), // AdMob Integration
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
    // We wrap this in a Material/Container so it has a solid background
    // when it sticks to the top.
    return Material(
      elevation: overlapsContent ? 4 : 0, // Adds shadow only when scrolling
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
