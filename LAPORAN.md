# Laporan Praktikum Arsitektur MVC dan MVVM Flutter

## Identitas

- Nama: GUNTUR AFANDI
- NIM: 362558302129
- Kelas: 2E TRPL

## Cara menjalankan

Jalankan dari folder `prak_arsitektur_tugas`:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

## Perbandingan arsitektur

| Pertanyaan | MVC | MVVM |
| :--- | :--- | :--- |
| Saat filter diketuk, class mana yang menerima aksi dan menyimpan pilihan? | `PengendaliTugas` lewat metode `ubahFilter(bool aktif)`. Nilai pilihan filter disimpan pada field `_hanyaBelumSelesai`. | `TugasViewModel` lewat metode `ubahFilter(bool aktif)`. Nilai filter juga disimpan di field `_hanyaBelumSelesai`. |
| Apa yang memicu rebuild dan bagaimana hasil saat pemicu dihapus? | Rebuild dipicu oleh `setState()` di dalam `_LayarMvcState._ubahFilter`. Saat `setState()` dihapus sementara, field filter tetap berubah menjadi `true` tetapi tampilan daftar tidak menyaring item, sehingga `filter_test.dart` gagal di baris 34 karena `Rancang UI Flutter` masih muncul. Sesudah `setState()` dipasang lagi, test kembali lulus. | Rebuild dipicu oleh `notifyListeners()` pada `TugasViewModel` yang didengarkan oleh `ListenableBuilder` di `LayarMvvm`. Waktu `notifyListeners()` pada `ubahFilter` dihapus sementara, state filter berubah di belakang layar tanpa rebuild UI dan `filter_test.dart` ikut gagal di baris 34. Setelah baris tersebut dikembalikan, test lulus lagi. |
| Kapan memilih pola ini? | Cocok dipakai pada halaman tunggal dengan interaksi pendek, misalnya satu form input dan daftar tanpa banyak tampilan turunan. Hubungan antara klik pengguna dan pemanggilan `setState()` mudah dilihat langsung di `layar_mvc.dart`. Risikonya, setiap handler baru seperti `_ubahFilter` harus diingat untuk memanggil `setState()`; kalau terlewat, data di controller berubah tetapi layar diam. | Lebih nyaman dipakai ketika satu sumber data menghasilkan beberapa nilai tampilan sekaligus, seperti daftar terfilter (`daftar`), hitungan total (`totalTugas` dan `jumlahSelesai`), dan teks error (`galat`). Penambahan `ubahFilter` di ViewModel tidak perlu pembungkus tambahan di `layar_mvvm.dart`, dan urutan notifikasinya bisa dicek di `logika_test.dart` tanpa widget. Biayanya ada pada pengelolaan `dispose()` di `LayarMvvm` serta kewajiban memanggil `notifyListeners()` di tiap metode mutasi. |

## Hasil percobaan dan keluaran terminal

Saat `setState()` di `_LayarMvcState._ubahFilter` (`lib/mvc/layar_mvc.dart`) dihapus sementara dan dijalankan `flutter test test/filter_test.dart`:

```text
00:00 +0: loading D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart
00:00 +0: filter belum selesai pada MVC
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following TestFailure was thrown running a test:
Expected: no matching candidates
  Actual: _TextWidgetFinder:<Found 1 widget with text "Rancang UI Flutter": [
            Text("Rancang UI Flutter", dependencies: [DefaultSelectionStyle, DefaultTextStyle,
MediaQuery]),
          ]>
   Which: means one was found but none were expected

When the exception was thrown, this was the stack:
#4      main.<anonymous closure> (file:///D:/PAK%20SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart:34:7)
<asynchronous suspension>
#5      testWidgets.<anonymous closure>.<anonymous closure> (package:flutter_test/src/widget_tester.dart:192:15)
<asynchronous suspension>
#6      TestWidgetsFlutterBinding._runTestBody (package:flutter_test/src/binding.dart:1059:5)
<asynchronous suspension>
<asynchronous suspension>
(elided one frame from package:stack_trace)

This was caught by the test expectation on the following line:
  file:///D:/PAK%20SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart line 34
The test description was:
  filter belum selesai pada MVC
════════════════════════════════════════════════════════════════════════════════════════════════════
00:01 +0 -1: filter belum selesai pada MVC [E]
  Test failed. See exception logs above.
  The test description was: filter belum selesai pada MVC
  
00:01 +0 -1: filter belum selesai pada MVVM
00:01 +1 -1: Some tests failed.
```

Saat `notifyListeners()` di `TugasViewModel.ubahFilter` (`lib/mvvm/tugas_view_model.dart`) dihapus sementara:

```text
00:00 +0: loading D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart
00:00 +0: filter belum selesai pada MVC
00:01 +1: filter belum selesai pada MVVM
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞════════════════════════════════════════════════════
The following TestFailure was thrown running a test:
Expected: no matching candidates
  Actual: _TextWidgetFinder:<Found 1 widget with text "Rancang UI Flutter": [
            Text("Rancang UI Flutter", dependencies: [DefaultSelectionStyle, DefaultTextStyle,
MediaQuery]),
          ]>
   Which: means one was found but none were expected

When the exception was thrown, this was the stack:
#4      main.<anonymous closure> (file:///D:/PAK%20SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart:34:7)
<asynchronous suspension>
#5      testWidgets.<anonymous closure>.<anonymous closure> (package:flutter_test/src/widget_tester.dart:192:15)
<asynchronous suspension>
#6      TestWidgetsFlutterBinding._runTestBody (package:flutter_test/src/binding.dart:1059:5)
<asynchronous suspension>
<asynchronous suspension>
(elided one frame from package:stack_trace)

This was caught by the test expectation on the following line:
  file:///D:/PAK%20SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart line 34
The test description was:
  filter belum selesai pada MVVM
════════════════════════════════════════════════════════════════════════════════════════════════════
00:01 +1 -1: filter belum selesai pada MVVM [E]
  Test failed. See exception logs above.
  The test description was: filter belum selesai pada MVVM
  
00:01 +1 -1: Some tests failed.
```

Keluaran `flutter analyze` dan `flutter test` setelah kode dipulihkan:

```text
Analyzing prak_arsitektur_tugas...                              
No issues found! (ran in 5.3s)

00:00 +0: loading D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart
00:00 +0: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart: filter belum selesai pada MVC
00:00 +1: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart: filter belum selesai pada MVC
00:00 +2: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart: filter belum selesai pada MVC
00:01 +3: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart: filter belum selesai pada MVC
00:01 +4: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/smoke_test.dart: beranda membuka kedua implementasi
00:01 +5: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/layar_test.dart: MVVM memperbarui form dan ringkasan
00:02 +6: D:/PAK SEPYSN/Starter-Praktikum-MVC-MVVM-Flutter/prak_arsitektur_tugas/test/filter_test.dart: filter belum selesai pada MVVM
00:02 +7: All tests passed!
```

## Tangkapan layar

Keempat gambar di folder `bukti/` diambil pada dua tugas yang sama dengan ringkasan `1 dari 2 selesai`:

- `bukti/mvc1.png` dan `bukti/mvc2.png` untuk kondisi filter mati dan aktif pada MVC.
- `bukti/mvvm1.png` dan `bukti/mvvm2.png` untuk kondisi yang sama pada MVVM.
