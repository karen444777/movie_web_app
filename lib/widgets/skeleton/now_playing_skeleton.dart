import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NowPlayingSkeleton extends StatelessWidget {
  const NowPlayingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            title: Container(
              height: 20,
              color: Colors.grey[800],
            ),
            subtitle: Container(
              height: 40,
              color: Colors.grey[800],
            ),
          );
        },
      ),
    );
  }
}
