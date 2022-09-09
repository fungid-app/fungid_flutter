

generate-icons:
	flutter pub run flutter_launcher_icons:main

generate-code:
	flutter pub run build_runner build --delete-conflicting-outputs

generate: generate-icons generate-code