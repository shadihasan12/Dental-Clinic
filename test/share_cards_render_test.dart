import 'dart:io';
import 'dart:ui' as ui;

import 'package:dental_clinic_app/features/statistics/presentation/share/cards/share_card_common.dart';
import 'package:dental_clinic_app/features/statistics/presentation/share/cards/share_card_template.dart';
import 'package:dental_clinic_app/features/statistics/presentation/share/share_statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Renders each share-card design at its native 1080x1920 and writes the
/// PNG to `build/share_cards/`, so the output can be eyeballed against the
/// original design without launching the app.
///
/// Not an assertion test — it is a visual harness. Run with:
///   flutter test test/share_cards_render_test.dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final data = ShareCardData(
    stats: ShareStatistics(
      startDate: DateTime(2026, 3, 15),
      endDate: DateTime(2026, 3, 21),
      visits: 1284,
      newPatients: 96,
      completedCases: 38,
      completionRate: 0.94,
      topTreatmentName: 'Teeth Whitening',
      topTreatmentCount: 142,
    ),
    doctorName: 'Dr. Sara Khaled',
    clinicName: 'Bright Smile Center',
    clinicCount: 3,
    daysOnPlatform: 214,
  );

  setUpAll(() async {
    // Widget tests default to a placeholder font; load the real Geist cuts
    // so the tracking and weights match the design.
    for (final entry in const {
      'assets/fonts/geist/Geist-Regular.ttf': FontWeight.w400,
      'assets/fonts/geist/Geist-Medium.ttf': FontWeight.w500,
      'assets/fonts/geist/Geist-SemiBold.ttf': FontWeight.w600,
      'assets/fonts/geist/Geist-Bold.ttf': FontWeight.w700,
      'assets/fonts/geist/Geist-ExtraBold.ttf': FontWeight.w800,
    }.entries) {
      final loader = FontLoader(ShareCardCanvas.fontFamily)
        ..addFont(rootBundle.load(entry.key));
      await loader.load();
    }
  });

  for (final template in ShareCardTemplate.values) {
    testWidgets('renders ${template.id}', (tester) async {
      tester.view
        ..physicalSize = const Size(
          ShareCardCanvas.width,
          ShareCardCanvas.height,
        )
        ..devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final boundaryKey = GlobalKey();

      await tester.runAsync(() async {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: MediaQuery(
              data: const MediaQueryData(
                size: Size(ShareCardCanvas.width, ShareCardCanvas.height),
              ),
              child: RepaintBoundary(
                key: boundaryKey,
                child: SizedBox(
                  width: ShareCardCanvas.width,
                  height: ShareCardCanvas.height,
                  child: template.build(data),
                ),
              ),
            ),
          ),
        );

        // The texture layers decode off-thread; give them a real async gap
        // or they snapshot as empty tiles.
        final ctx = boundaryKey.currentContext!;
        for (final asset in const [
          ShareCardCanvas.grainAsset,
          ShareCardCanvas.editorialContoursAsset,
        ]) {
          await precacheImage(AssetImage(asset), ctx);
        }
        await Future<void>.delayed(const Duration(milliseconds: 400));
        await tester.pump();
        await Future<void>.delayed(const Duration(milliseconds: 200));
      });

      await tester.pump();

      final boundary = boundaryKey.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      late final Uint8List bytes;
      await tester.runAsync(() async {
        final image = await boundary.toImage(pixelRatio: 1.0);
        final byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        bytes = byteData!.buffer.asUint8List();
      });

      final dir = Directory('build/share_cards')..createSync(recursive: true);
      File('${dir.path}/${template.id}.png').writeAsBytesSync(bytes);
      // ignore: avoid_print
      print('wrote build/share_cards/${template.id}.png (${bytes.length} B)');
    });
  }
}
