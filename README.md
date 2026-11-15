# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tugas 7

Halaman utama menampilkan nama lengkap, NPM, dan kelas pemilik. Tiga kartu aksi
Lihat Proyek, Tambah Proyek, dan Logout memiliki warna berbeda dan menampilkan
SnackBar sesuai tombol yang ditekan. Menu tersebut merupakan demonstrasi tampilan;
fitur proyek dan autentikasi belum terhubung ke backend. Kartu menyesuaikan ukuran
layar dan halaman dapat digulir ketika ruang layar terbatas.

#### Menjalankan proyek

Pasang Flutter SDK dan Chrome, lalu jalankan perintah berikut di folder proyek:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Untuk Android, siapkan Android Studio dan Android SDK, lalu periksa perangkat
melalui `flutter doctor` dan `flutter devices`.

#### Jawaban pertanyaan reflektif

1. **Widget tree** adalah susunan bertingkat widget yang membentuk antarmuka.
   Widget induk menerima widget anak melalui `child` atau `children`. Dalam
   aplikasi ini, `MaterialApp` menampilkan `MyHomePage`, yang berisi `Scaffold`,
   lalu bagian `body` berisi susunan widget untuk kartu profil dan menu.

2. **Widget yang digunakan:** `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard`
   adalah widget buatan proyek. `MaterialApp` mengatur aplikasi; `Scaffold`
   menyediakan kerangka halaman; `AppBar` menampilkan bilah atas. `LayoutBuilder`
   menyediakan ukuran ruang yang tersedia; `SingleChildScrollView` memungkinkan
   konten digulir; `Center` memusatkan anak; `ConstrainedBox` membatasi lebar;
   `Column` menyusun vertikal; `Wrap` mengatur kartu mengikuti lebar; `SizedBox`
   memberi ukuran atau jarak; `GridView.count` menyusun kartu aksi dalam kisi;
   `Text` dan `Icon` menampilkan teks dan ikon; `Card` membungkus informasi;
   `Padding` memberi ruang; `Material` memberi permukaan berwarna; `InkWell`
   menangani sentuhan dan efek visual; `SnackBar` menampilkan pesan sementara.

3. **MaterialApp** menyediakan konfigurasi tingkat aplikasi, termasuk tema dan
   halaman awal, serta menghubungkan layanan navigasi dan Material. Widget ini
   umum dipakai dekat akar aplikasi Flutter berbasis Material agar tema dan
   layanan tersebut tersedia bagi widget turunannya.

4. **StatelessWidget** sesuai ketika tampilan ditentukan oleh konfigurasi yang
   diberikan dan tidak membutuhkan state lokal yang berubah. **StatefulWidget**
   memiliki objek State untuk data lokal yang dapat berubah selama widget hidup,
   misalnya counter atau isian interaktif. Halaman ini dapat menjadi stateless
   karena data profil dan menu tetap; SnackBar dikelola ScaffoldMessenger.

5. **BuildContext** menunjukkan posisi widget di widget tree dan memungkinkan
   widget mengakses data atau layanan dari leluhurnya. Method `build` menerima
   context untuk menyusun tampilan. Contohnya, `Theme.of(context)` mendapatkan
   tema, dan `ScaffoldMessenger.of(context)` mendapatkan pengelola SnackBar.

6. **Hot reload** menerapkan banyak perubahan kode ke aplikasi yang berjalan
   sambil berusaha mempertahankan state; **hot restart** memulai ulang aplikasi
   Dart dan mereset state. Perubahan inisialisasi seperti `main()` atau
   initializers sering memerlukan hot restart. Perubahan kode native, konfigurasi
   platform atau plugin dapat memerlukan penghentian dan menjalankan ulang aplikasi
   secara penuh. Perubahan dependencies juga dapat memerlukan `flutter pub get`.

#### Progres dan pemeriksaan

Tugas 7 melanjutkan proyek Flutter Tutorial 08 pada repositori yang sama dan
terpisah dari proyek Django. Perubahan minggu ini mencakup identitas lengkap,
warna kartu aksi yang berbeda, tata letak responsif, dan tes widget.

- `flutter analyze`: lulus tanpa isu.
- `flutter test`: dua tes widget lulus. Tes mencakup identitas, ikon, warna
  kartu yang berbeda, pesan SnackBar untuk setiap aksi, dan scroll pada
  ukuran layar 320 × 480.
- Pemeriksaan visual langsung atas tampilan akhir di Chrome dan pengujian
  pada perangkat Android belum dilakukan untuk perubahan Tugas 7 ini.
- Tombol hanya menampilkan SnackBar; belum membuka daftar, menyimpan proyek,
  atau menjalankan proses logout sesungguhnya.

#### Bantuan AI

Saya menggunakan ChatGPT sebagai pendamping belajar untuk memahami konsep
Flutter dan Dart, mendiskusikan struktur aplikasi portofolio, serta membantu
implementasi, pengujian, dan penyusunan dokumentasi Tugas 7.

Strategi prompting yang digunakan adalah memberikan tautan instruksi tugas
agar pembahasan sesuai dengan materi, mengajukan pertanyaan tentang konsep yang
belum dipahami, dan meminta pemeriksaan ulang terhadap hasil pengerjaan.
Pembelajaran dilakukan bertahap sejak Tutorial 08, yang menjadi dasar proyek ini.

Bagian spesifik yang dibantu ChatGPT meliputi:

- Penjelasan susunan widget, hubungan induk-anak, penggunaan `StatelessWidget`,
  serta fungsi `InfoCard`, `ItemCard`, dan `SnackBar`.
- Penyesuaian kode identitas profil dan warna setiap kartu aksi melalui atribut
  `color` pada model `ItemHomepage`.
- Perubahan tata letak agar kartu menyesuaikan lebar layar dan halaman dapat
  digulir pada layar kecil.
- Penyusunan dan pelaksanaan tes widget untuk identitas, ikon, warna kartu,
  pesan SnackBar, dan scroll, serta pemeriksaan dengan `flutter analyze`.
- Penyusunan draf jawaban reflektif dan pemeriksaan kesesuaian README dengan
  instruksi tugas tanpa menghapus dokumentasi sebelumnya.

Contoh pertanyaan selama pembelajaran Flutter sejak Tutorial 08:

- “snackbar tuh yg notif d bawah yaa” untuk memastikan pemahaman fungsi SnackBar.
- “ini dh bnr smw?” disertai kode `MyHomePage` dan `InfoCard` untuk meminta
  pemeriksaan susunan widget.

Hasil bantuan ChatGPT tetap perlu diperiksa. Saat peninjauan Tugas 7, tambahan
bagian Tutorial 08 yang tidak diperlukan dihapus dan heading Tugas 7 disesuaikan
dengan instruksi. Analisis kode dan dua tes widget telah lulus, tetapi hasil
tersebut belum membuktikan bahwa seluruh tampilan nyaman digunakan di perangkat
nyata.
