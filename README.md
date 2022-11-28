# buzzar-id mobile 🐝
Sebuah wadah bagi para pemilik UMKM dan pelanggan untuk berinteraksi dan mengenal karya wirausaha.<br> 
Proyek ini dibuat untuk memenuhi Proyek Tengah Semester Mata Kuliah Pemrograman Berbasis Plaform oleh Fakultas Ilmu Komputer Universitas Indonesia pada Tahun Ajaran 2022/2023.

## Anggota Kelompok 🙋🏻‍♂️🙋🏻‍♀️
Proyek ini dibuat oleh kelompok C-11 yang beranggotakan:
1. [Ahmad Hanif Adisetya](https://github.com/ahmadhanif3) (2106750603)
2. [Emir Shamsuddin Fadhlurrahman](https://github.com/Emyr298) (2106632541)
3. [Kevin Alexander](https://github.com/kevin-alex-12) (2106705026)
4. [Muhammad Nabiel Andityo Purnomo](https://github.com/mnabielap) (2106750465)
5. [Vania Azria Wardani](https://github.com/vaniaazr) (2106650380)

## Overview 🌐
Pada **buzzar-id mobile**, yaitu versi mobile dari aplikasi web **buzzar-id**. **buzzar-id mobile** memiliki fitur yang sama dengan versi web dan dibuat lebih sederhana agar pengguna mobile dapat menjalankan aplikasi ini secara ringan dan mudah. Terdapat sedikit perbedaan pada aplikasi mobile dibandingkan web, yaitu pada sisi tampilan yang lebih dibuat khusus untuk perangkat dengan layar kecil dan beberapa penggunaan fitur yang berbeda dibandingkan dengan versi web, tetapi tetap memiliki tujuan yang sama.
<br><br>
Pada **buzzar-id mobile**, terdapat lima fitur utama yang dapat diakses oleh pengguna, yaitu:
- Fitur pertama yaitu fitur _showcase_ dimana berbagai UMKM yang telah memiliki cabang digital di tempat lain akan ditampilkan. Meskipun begitu, tidak menutup kemungkinan bagi UMKM yang belum memiliki cabang digital untuk dapat bergabung.
- Fitur kedua yaitu fitur _news_ dimana pemilik UMKM dan _admin_ dapat mempublikasikan informasi menarik seperti promosi, dsb. yang nantinya dapat dilihat oleh para _customer_.
- Fitur ketiga yaitu fitur obrolan dimana _customer_ dapat berbincang dengan pemilik UMKM. Hal ini biasanya sulit dilakukan karena jarang pemilik UMKM menyediakan layanan ini secara daring.
- Fitur keempat yaitu fitur _products_ dimana _customer_ dapat melihat produk-produk yang ditawarkan oleh UMKM dalam berbagai cabang digital.
- Fitur kelima yaitu fitur lomba dimana pemilik UMKM dapat melombakan sesuatu (misal: desain produk, tergantung lombanya) dan memperoleh _vote_ dari para _customer_ pada durasi _event_. Penyelenggara dari lomba adalah _admin_.

## Daftar Modul 🔍
Berikut adalah daftar modul yang akan kami implementasikan.
- _Showcase_ - [Ahmad Hanif Adisetya](https://github.com/ahmadhanif3)
- _Products_ - [Vania Azria Wardani](https://github.com/vaniaazr)
- _News_ - [Emir Shamsuddin Fadhlurrahman](https://github.com/Emyr298)
- Obrolan - [Muhammad Nabiel Andityo Purnomo](https://github.com/mnabielap)
- Lomba - [Kevin Alexander](https://github.com/kevin-alex-12)

## Peran Pengguna 👥
Pengguna yang login dibagi menjadi 2, pemilik UMKM dan _customer_.

### **Pengguna Tidak _Logged-In_**<br>    
Hanya memiliki _basic features_:
1) Melihat berita 
2) Melihat _showcase_ UMKM
3) Melihat produk-produk UMKM
4) Melihat lomba dan sesuatu yang diikutsertakan ke dalam lomba
5) Melihat kumpulan diskusi pada suatu UMKM

### **Pengguna _Logged-In_**<br>
#### **UMKM**<br>
Memiliki semua basic features dengan tambahan:
1) Mempublikasikan berita
2) Mengatur data dari UMKM yang dimiliki
3) Menambahkan produk
4) Ikutserta dalam perlombaan
5) Menambahkan dan menjawab diskusi

#### **_Customer_**<br>
Memiliki semua basic features dengan tambahan:
1) Melakukan subskripsi UMKM news
2) Memberikan rating terhadap UMKM
3) Melakukan _voting_ dalam perlombaan
4) Menambahkan dan menjawab diskusi
5) Melihat produk-produk UMKM

## Alur Pengintegrasian dengan _Web Service_ 📡
- Pertama, tambahkan package http pada flutter terlebih dahulu dan import package tersebut pada file dart yang sesuai.
- Ubah pengaturan pada file AndroidManifest.xml agar diizinkan menggunakan internet.
- Buat terlebih dahulu custom class pada dart sehingga data json yang akan diambil dapat diolah dengan lebih mudah. Custom class akan berbeda-beda, tergantung dengan data yang akan diambil.
- Buat class Future pada dart agar dapat berjalan secara asynchronous dan digunakan untuk mengambil data json.
- Aplikasi buzzar-id mobile akan meminta data json sesuai dengan url endpoint yang ingin diambil menggunakan class Future yang telah dibuat sebelumnya. Pengambilan data tersebut dapat diimplementasikan dalam berbagai cara, salah satunya function.
- Jika data json tersebut berhasil diambil dan tidak ada eror, ubah ke dalam bentuk custom class yang telah dibuat sebelumnya.
- Masing-masing fitur akan mengolah data dalam bentuk custom class tersebut sesuai dengan kebutuhan dan tampilan yang diinginkan.
- Jika ingin mengirim data ke server, langkah yang dilakukan mirip seperti meminta data, tetapi ubah method yang digunakan dan masukkan data yang perlu dikirim.

## Referensi 🌐
- https://www.bi.go.id/id/g20/default.aspx
- https://blog.healthchecks.io/2020/11/using-github-actions-to-run-django-tests/
- https://docs.flutter.dev/cookbook/networking/fetch-data
- https://www.geeksforgeeks.org/implementing-rest-api-in-flutter/