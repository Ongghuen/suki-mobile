#### Notes/Deskripsi
this and that something ini itu and whatnot ya gitulah pokonya ini projek
- REST Api: [Laravel](https://github.com/ongghuen/web-backend) 
- State Management: [BLoC](https://bloclibrary.dev/) 
- Local Storage : [Hydrated BLoC](https://pub.dev/packages/hydrated_bloc) 
- List Dependencies (perlu) `pubspec.yaml`:
  - google_fonts
  - http
  - flutter_bloc
  - equatable
  - hydrated_bloc (late game)

<hr/>

##### Ganti IP API
di blabla/data/api/`call.dart`
```dart
class CallApi {
  final String _url = "http://192.168.0.116:8000"; <----- INI GANTI SESUAI LOCAL NETWORK LARAVEL
...
```

<hr/>

##### TODO
- [x] ~~Akses Firebase Data (gak guna sekarang wow)~~
- [x] Tidur 8 jam tiap hari
- [ ] Project "Selesai"

<hr/>

Referensi:
- Backend API Laravel: [here](https://github.com/Ongghuen/web-backend) 
