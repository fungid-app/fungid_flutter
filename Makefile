

generate-icons:
	flutter pub run flutter_launcher_icons:main

get-openapi:
	wget https://api.fungid.app/openapi.json -O fungid-openapi.json

generate-code: get-openapi
	flutter pub run build_runner build --delete-conflicting-outputs

generate: generate-icons generate-code 