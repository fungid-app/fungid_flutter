

generate-icons:
	flutter pub run flutter_launcher_icons:main

get-openapi:
	wget https://api.fungid.app/openapi.json -O fungid-openapi.json

generate-code: get-openapi
	flutter pub run build_runner build --delete-conflicting-outputs

generate: generate-icons generate-code 

deploy-beta: deploy-android-draft deploy-ios-beta

clean:
	flutter clean

deploy-ios-beta:
	flutter clean \
	&& flutter build ipa \
	&& cd ios \
	&& fastlane ios beta

deploy-android-draft:
	flutter clean \
	&& flutter build appbundle \
	&& cd android \
	&& fastlane android draft

deploy-android-release:
	flutter build appbundle \
	&& cd android \
	&& fastlane android release

generate-imagedb-file:
	sqlite3 ../fungid-api/dbs/gbif.sqlite3 < app_db/create-image-table.sql \
	&& sqlite3 ../fungid-api/dbs/gbif.sqlite3 ".dump classifier_species_images" > assets/db/images.sql \
	&& sqlite3 ../fungid-api/dbs/gbif.sqlite3 "DROP TABLE classifier_species_images;"
	

	
check-size:
	flutter clean \
	&& flutter build appbundle --analyze-size --target-platform android-arm64