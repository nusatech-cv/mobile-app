import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pijetin/domain/controller/location_controller.dart';
import 'package:pijetin/domain/controller/test/test_main.dart';
import 'package:pijetin/view/pages/auth/Onboarding/onboarding_page.dart';
import 'package:pijetin/view/widget/map_picker.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  group('onboarding', () {
    testWidgets('Tap button next', (tester) async {
      await tester.pumpWidget(TestMain(
        child: OnboardingPage(),
      ));

      await tester.tap(
          find.byKey(
            const Key('next'),
          ),
          warnIfMissed: false);
    });

    testWidgets('Tap button skip', (tester) async {
      await tester.pumpWidget(TestMain(
        child: OnboardingPage(),
      ));

      await tester.tap(
          find.byKey(
            const Key('skip'),
          ),
          warnIfMissed: false);
    });
  });

  group('maps', () {
    Get.put(LocationController());

    testWidgets('pick map', (tester) async {
      await tester.pumpWidget(TestMain(
        child: MapPicker(),
      ));

      await tester.tap(find.byKey(const Key('pickLocation')));
    });
  });
}
