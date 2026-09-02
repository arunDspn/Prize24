#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=prize24-dev \
      --out=lib/firebase_options_dev.dart \
      --ios-bundle-id=com.kintlearn.prize24-app.dev \
      --ios-out=ios/flavors/dev/GoogleService-Info.plist \
      --android-package-name=com.kintlearn.prize24_app.dev \
      --android-out=android/app/src/development/google-services.json
    ;;
  stg)
    flutterfire config \
      --project=prize24-stg \
      --out=lib/firebase_options_stg.dart \
      --ios-bundle-id=com.kintlearn.prize24-app.staging \
      --ios-out=ios/flavors/stg/GoogleService-Info.plist \
      --android-package-name=com.kintlearn.prize24_app.staging \
      --android-out=android/app/src/staging/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=prize24 \
      --out=lib/firebase_options_prod.dart \
      --ios-bundle-id=com.kintlearn.prize24-app \
      --ios-out=ios/flavors/prod/GoogleService-Info.plist \
      --android-package-name=com.kintlearn.prize24_app \
      --android-out=android/app/src/prod/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac