import 'package:flutter/material.dart';
import 'package:flutter_app/rides/models/ride.dart';
import 'package:flutter_app/util/custom_timeline_theme.dart';
import 'package:flutter_app/util/locale_manager.dart';
import 'package:flutter_app/util/trip/trip_card.dart';
import 'package:timelines/timelines.dart';

import '../../rides/pages/ride_detail_page.dart';

class RideCard extends TripCard<Ride> {
  const RideCard(super.trip, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RideDetailPage.fromRide(trip),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(localeManager.formatDate(trip.startTime)),
            ),
            const Divider(),
            FixedTimeline(
              theme: CustomTimelineTheme.of(context),
              children: [
                TimelineTile(
                  contents: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${localeManager.formatTime(trip.startTime)}  ${trip.start}'),
                      ],
                    ),
                  ),
                  node: const TimelineNode(
                    indicator: CustomOutlinedDotIndicator(),
                    endConnector: CustomSolidLineConnector(),
                  ),
                ),
                TimelineTile(
                  contents: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${localeManager.formatTime(trip.endTime)}  ${trip.end}'),
                      ],
                    ),
                  ),
                  node: const TimelineNode(
                    indicator: CustomOutlinedDotIndicator(),
                    startConnector: CustomSolidLineConnector(),
                  ),
                )
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Max'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
