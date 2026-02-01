Place the provided logo image into the Flutter assets folder used by the app.

Steps:
1. Create the folder: `assets/images/` at the project root.
2. Put your `logo.png` (the attached logo) into `assets/images/logo.png`.
3. The app expects that path and the `pubspec.yaml` already references it.

Notes:
- If you want to test without the real image, you can put any PNG named `logo.png` in that path.
- After placing the file run:

```bash
flutter pub get
flutter run
```
