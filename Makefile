

generate-icons:
	flutter pub run flutter_launcher_icons:main

get-openapi:
	wget https://api.fungid.app/openapi.json -O fungid-openapi.json

generate-code: get-openapi
	flutter pub run build_runner build --delete-conflicting-outputs

generate: generate-icons generate-code 

deploy: deploy-android deploy-ios

deploy-ios:
	flutter build ipa \
	&& cd ios \
	&& fastlane ios beta

deploy-android:
	flutter build appbundle \
	&& cd android \
	&& fastlane android draft