export KEYSTORE_FILE="C:/Users/remoraj90/VSCodePc/keystore/debug.keystore"
export KEYSTORE_PASSWORD="android"
export KEY_ALIAS="androiddebugkey"
export KEY_PASSWORD="android"
flutter clean
flutter pub get
flutter build apk --release
