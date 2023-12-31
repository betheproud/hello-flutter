if [ "$CONFIGURATION" == "Debug-dev" ] || [ "$CONFIGURATION" == "Release-dev" ]; then
  cp Runner/dev/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-sandbox" ] || [ "$CONFIGURATION" == "Release-sandbox" ]; then
  cp Runner/sandbox/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-qa" ] || [ "$CONFIGURATION" == "Release-qa" ]; then
  cp Runner/qa/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-prod" ] || [ "$CONFIGURATION" == "Release-prod" ]; then
  cp Runner/prod/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-third" ] || [ "$CONFIGURATION" == "Release-third" ]; then
  cp Runner/third/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

