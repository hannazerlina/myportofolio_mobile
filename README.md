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

### Tutorial 9

[Tutorial 9 PBP](https://pbp.cs.ui.ac.id/tutorial/tutorial-9.html) menambahkan
navigasi dan formulir ke aplikasi portofolio Flutter.

- **Navigasi.** Drawer membuka Home atau Tambah Proyek. Kartu Tambah Proyek
  memakai `Navigator.push()` sehingga tombol Back bisa kembali ke Home.
  Drawer mengganti halaman dengan `pushReplacement()`. Jika Home sudah ada
  di riwayat, memilih Home dari form cukup menutup halaman form dengan `pop()`.
- **Form.** Pengguna mengisi nama, deskripsi, kategori, teknologi, dan tautan.
  Nama dan deskripsi wajib diisi. Save menampilkan ringkasan kelima isian
  di pop-up. OK mengosongkan isian dan mengembalikan kategori ke nilai awal.
  Data form hanya ditampilkan selama demo dan belum disimpan ke database.
- **Struktur.** Halaman Home dan form berada di `lib/screens`. Drawer dan
  kartu proyek berada di `lib/widgets`. Tampilan memakai paket `material_ui`.

Jalankan `flutter pub get` dan `flutter run -d chrome` dari folder proyek.
Untuk mencoba validasi, tekan Save dengan form kosong, lalu isi nama dan
deskripsi dan tekan Save lagi. Cek ringkasan, tutup dengan OK, dan pastikan
form kembali kosong.

`flutter analyze` tidak menemukan masalah. Ketujuh tes widget lulus,
termasuk navigasi dari drawer dan kartu, validasi isian kosong, reset form,
dan gulir pop-up di layar kecil.

### Tugas 8

Halaman Tambah Pendidikan melanjutkan aplikasi portofolio Flutter dari
Tutorial 9. Form memuat nama institusi, program studi, tahun masuk, dan tahun
selesai. Tahun selesai bersifat opsional. Pilihan **Masih menempuh pendidikan**
menyembunyikan kolom tersebut. Setelah isian lolos validasi, **Simpan**
menampilkan ringkasan di dialog. Tombol **Tutup** kembali ke form dengan
isian yang sama.

#### Menjalankan proyek

Jalankan perintah berikut dari folder proyek Flutter.

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d chrome
```

Buka **Tambah Pendidikan** dari kartu di Home atau lewat drawer. Coba tekan
**Simpan** saat kolom wajib kosong, lalu lengkapi isian untuk melihat
ringkasannya. Pilih **Home** di drawer untuk kembali ke halaman utama.

#### Jawaban pertanyaan reflektif

1. **Navigasi** memakai tiga metode. `Navigator.push()` menambahkan halaman ke
   tumpukan sehingga tombol Back bisa kembali ke halaman sebelumnya. Metode
   ini dipakai saat form dibuka dari kartu Home. `Navigator.pushReplacement()`
   mengganti halaman aktif, seperti saat form dibuka lewat drawer.
   `Navigator.pop()` menutup lapisan aktif, misalnya dialog atau drawer.
   Saat opsi Home dipilih, drawer ditutup terlebih dahulu. Jika Home sudah
   ada di bawah form, `pop()` menutup form. Jika form menjadi halaman utama,
   `pushReplacement()` menggantinya dengan Home.

2. **Scaffold, AppBar, dan Drawer** memberi struktur yang konsisten pada
   halaman. `Scaffold` menempatkan bilah atas, menu samping, dan isi halaman.
   `AppBar` menunjukkan judul halaman dan memberi akses ke menu samping.
   `LeftDrawer` yang sama menyediakan pilihan Home, Tambah Proyek, dan
   Tambah Pendidikan. AppBar di halaman Home dan Tambah Pendidikan memakai
   warna utama dari `Theme.of(context).colorScheme.primary`.

3. **Tata letak form** memakai `Column` agar kolom isian tersusun ke bawah
   mengikuti urutan pengisian. `SizedBox` memberi jarak antarinput dan
   padding memberi ruang di tepi form. `ConstrainedBox` membatasi lebar
   form pada layar besar. `SingleChildScrollView` membuat isian dan tombol
   Simpan tetap bisa dijangkau saat layar sempit atau papan ketik tampil.

4. **Validasi form** menggunakan `GlobalKey<FormState>` untuk mengakses
   `FormState`. Tombol Simpan memanggil `validate()` untuk menjalankan
   setiap `validator`. Pesan kesalahan muncul di kolom yang perlu diperbaiki.
   Contohnya, tahun selesai 2024 ditolak jika tahun masuk 2025. Papan ketik
   angka memudahkan pengisian, tetapi pengguna masih bisa menempelkan teks,
   dan urutan dua tahun tetap perlu diperiksa oleh validator.

#### Progres dan pemeriksaan

Tugas 8 menambahkan form Pendidikan di `lib/screens` dan menghubungkannya
ke kartu Home serta `LeftDrawer`. Ringkasan ditampilkan di dialog lokal.

- `flutter analyze --no-pub` tidak menemukan masalah.
- `flutter test --no-pub` meluluskan 11 tes widget. Tes mencakup navigasi,
  kolom kosong, batas 200 karakter, format empat digit, urutan tahun, dan
  akses ke tombol Simpan pada layar sempit saat papan ketik tampil.
- Dua tes navigasi di Chrome lulus, termasuk membuka form dari kartu
  atau drawer dan kembali ke Home.

#### Bantuan AI

Saya menggunakan ChatGPT untuk membahas instruksi Tugas 8 dan mencocokkan
kolom formulir dengan model Education di portofolio. Bantuan mencakup
implementasi form dan navigasi, penyusunan tes, serta draf refleksi.
Hasilnya diperiksa dengan analisis kode dan tes widget, termasuk urutan
tahun dan alur kembali ke Home.

##### Materi yang dibahas

Pembahasan dengan ChatGPT mengacu pada materi Flutter di Tugas 8. Beberapa konsep yang dibahas beserta contohnya:

- **Navigasi halaman.** `Navigator.push()` membuka form dari kartu Tambah Pendidikan sambil menyimpan halaman Home di riwayat. Tombol Back kemudian bisa menutup form dengan `Navigator.pop()`. Saat memilih halaman lain lewat drawer, `Navigator.pushReplacement()` mengganti halaman yang sedang dibuka.
- **Validasi formulir.** Tombol **Simpan** memanggil `FormState.validate()` sebelum menampilkan ringkasan. Contohnya, tahun selesai 2024 ditolak jika tahun masuknya 2025. Jika tahun selesai dibiarkan kosong, ringkasan menampilkan **Masih berlangsung**.
- **Tata letak di layar kecil.** `Column` menyusun kolom isian secara vertikal, `SizedBox` memberi jarak, dan `SingleChildScrollView` membuat tombol **Simpan** tetap bisa dijangkau saat papan ketik tampil.

### Tutorial 10

Portofolio Flutter terhubung ke Django untuk pendaftaran, login, logout,
daftar dan detail proyek, serta penyimpanan proyek. Akun pemilik portofolio
bisa menyimpan proyek melalui API. Form memakai kolom judul, peran, tahun,
deskripsi, dan tautan opsional dari model Project.

#### Menjalankan proyek

Dari folder Django, aktifkan virtual environment lalu jalankan:

```bash
python -m pip install -r requirements.txt
python -B manage.py runserver 127.0.0.1:8000
```

Dari folder Flutter, jalankan:

```bash
flutter pub get
flutter run -d chrome --web-hostname 127.0.0.1 --web-port 8099
```

Buka **Lihat Proyek** untuk mengambil daftar dari Django, lalu pilih salah
satu untuk melihat detail. Gunakan **Masuk** untuk login atau mendaftar.
Setelah masuk dengan akun pemilik lokal, coba **Tambah Proyek** dan periksa
hasilnya pada daftar proyek. **Logout** mengakhiri sesi.

Port Flutter 8099 masuk daftar asal web yang diizinkan pada pengaturan
lokal Django. Untuk lingkungan lain, atur `MOBILE_WEB_ORIGINS` di Django
dan alamat Django melalui `--dart-define=DJANGO_BASE_URL=...` saat
menjalankan Flutter.

#### Progres dan pemeriksaan

- Django menggunakan autentikasi sesi dan token CSRF untuk permintaan yang
  mengubah data. Form proyek memakai izin pemilik dari API Django.
- `flutter analyze --no-pub` bersih. Sebanyak 12 tes widget Flutter lulus
  di Chrome dengan respons uji. Sebanyak 15 tes Django lulus, termasuk
  pemeriksaan sesi, CSRF, dan izin API.
- Endpoint sesi dan daftar proyek juga diperiksa langsung saat server
  Django lokal berjalan.

#### Rujukan dan bantuan

Implementasi mengacu pada [materi integrasi Flutter dan Django semester sebelumnya](https://pbp-fasilkom-ui.github.io/ganjil-2026/en/docs/tutorial-8)
karena halaman [Tutorial 10](https://pbp.cs.ui.ac.id/tutorial/tutorial-10.html)
mengembalikan HTTP 429 saat diperiksa. ChatGPT membantu implementasi dan
pengujian alur integrasi.
