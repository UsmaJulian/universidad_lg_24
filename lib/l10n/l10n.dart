import 'package:flutter/widgets.dart';

import 'package:universidad_lg_24/l10n/arb/app_localizations.dart';

export 'package:universidad_lg_24/l10n/arb/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
