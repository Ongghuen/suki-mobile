#### Notes/Deskripsi
this and that something ini itu and whatnot ya gitulah pokonya ini projek
- REST Api: [Laravel](https://github.com/ongghuen/web-backend) 
- State Management: [BLoC](https://bloclibrary.dev/) 
- Local Storage : [Hydrated BLoC](https://pub.dev/packages/hydrated_bloc) 
- List Dependencies `pubspec.yaml`:
  - google_fonts
  - http
  - flutter_bloc
  - equatable
  - hydrated_bloc
  - lottie (make dikit)

<hr/>

##### Ganti IP API
di `lib/presentation/utils/default.dart`
```dart
// const url = "http://192.168.43.112:8000"; <-- ganti sesuai ip local network laravel
const url = "http://10.0.2.2:8000";

// url api yang dipake
const apiUrl = url;
const apiUrlStorage = "$apiUrl/storage/";
...
```

<hr/>

##### TODO
- [x] ~~Akses Firebase Data (gak guna sekarang wow)~~
- [x] Tidur 8 jam tiap hari hahay
- [ ] Project "Selesai"

<hr/>

Referensi:
- Backend API Laravel: [here](https://github.com/Ongghuen/web-backend) 
