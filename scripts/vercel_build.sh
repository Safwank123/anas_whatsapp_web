#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-stable}"
FLUTTER_HOME="$PWD/.vercel_flutter"

if [ ! -d "$FLUTTER_HOME" ]; then
  git clone https://github.com/flutter/flutter.git "$FLUTTER_HOME" --branch "$FLUTTER_VERSION" --depth 1
fi

export PATH="$FLUTTER_HOME/bin:$PATH"

flutter config --enable-web
flutter pub get
flutter build web --release
