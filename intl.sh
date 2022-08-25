#!/usr/bin/env bash
flutter pub run intl_generator:extract_to_arb --output-dir=l10n-arb/home lib/l10n/home/localization_intl.dart
flutter pub run intl_generator:generate_from_arb --output-dir=lib/l10n/home --no-use-deferred-loading lib/l10n/home/localization_intl.dart l10n-arb/home/intl_*.arb
