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
Forum G20 merupakan forum kerja sama multilateral yang terdiri dari 19 negara utama dan Uni Eropa. G20 dibentuk pada 1999 atas inisiasi anggota G7. Forum G20 merangkul negara maju dan berkembang untuk bersama-sama mengatasi krisis dan bertujuan mewujudkan pertumbuhan global yang kuat, berkelanjutan, seimbang, dan inklusif. Pada tahun 2022, Indonesia memegang presidensi G20. Tema Presidensi G20 Indonesia 2022 yang diusung adalah *Recover Together, Recover Stronger*. Dengan tema tersebut, Indonesia mengajak seluruh dunia untuk saling mendukung pulih bersama serta tumbuh lebih kuat dan berkelanjutan. 
<br><br>
Salah satu isu utama yang diusung pada G20 tahun ini adalah **Transformasi Digital**. Menerapkan digitalisasi terhadap tatanan ekonomi dapat memulihkannya serta menjadi lebih kuat, inklusif dan kolaboratif. Salah satu kunci dalam pemulihan tatanan ekonomi adalah dengan pemberdayaan UMKM untuk mengakselerasikannya. Kelompok kami mencoba untuk memperdayakan hal tersebut, maka kami usung aplikasi web yang bernama **buzzar-id**. **buzzar-id** adalah sebuah wadah bagi para pemilik UMKM dan pelanggan untuk berinteraksi dan mengenal karya wirausaha.
<br><br>
Pada **buzzar-id**, terdapat lima fitur utama yang dapat diakses oleh pengguna. Fitur pertama yaitu fitur _showcase_ dimana berbagai UMKM yang telah memiliki cabang digital di tempat lain akan ditampilkan. Meskipun begitu, tidak menutup kemungkinan bagi UMKM yang belum memiliki cabang digital untuk dapat bergabung. Fitur kedua yaitu fitur _news_ dimana pemilik UMKM dan _admin_ dapat mempublikasikan informasi menarik seperti promosi, dsb. yang nantinya dapat dilihat oleh para _customer_. Fitur ketiga yaitu fitur obrolan dimana _customer_ dapat berbincang dengan pemilik UMKM. Hal ini biasanya sulit dilakukan karena jarang pemilik UMKM menyediakan layanan ini secara daring. Fitur keempat yaitu fitur _products_ dimana _customer_ dapat melihat produk-produk yang ditawarkan oleh UMKM dalam berbagai cabang digital. Fitur kelima yaitu fitur lomba dimana pemilik UMKM dapat melombakan sesuatu (misal: desain produk, tergantung lombanya) dan memperoleh _vote_ dari para _customer_ pada durasi _event_. Umumnya penyelenggara dari lomba adalah _admin_.
<br><br>
Dengan adanya situs web ini, kami ingin masyarakat umum dapat lebih mudah dalam pencarian UMKM beserta informasi-informasinya sehingga UMKM-UMKM tersebut dapat berkembang dengan lebih baik.
<br><br>
Selain itu, terdapat juga buzzar-id mobile, yaitu versi mobile dari aplikasi web buzzar-id. buzzar-id mobile memiliki fitur yang sama dengan versi web dan dibuat lebih sederhana agar pengguna mobile dapat menjalankan aplikasi ini secara ringan dan mudah. Terdapat sedikit perbedaan pada aplikasi mobile dibandingkan web, yaitu pada sisi tampilan yang lebih dibuat khusus untuk perangkat dengan layar kecil dan beberapa penggunaan fitur yang berbeda dibandingkan dengan versi web, tetapi tetap memiliki tujuan yang sama.

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
Aplikasi buzzar-id mobile akan meminta data json sesuai dengan url endpoint yang ingin diambil. Data json tersebut akan diubah ke dalam bentuk custom class yang disesuaikan dengan kebutuhan masing-masing fitur pada aplikasi. Masing-masing fitur akan mengolah data dalam bentuk custom class tersebut sesuai dengan kebutuhan dan tampilan yang diinginkan.

## Referensi 🌐
- https://www.bi.go.id/id/g20/default.aspx
- https://blog.healthchecks.io/2020/11/using-github-actions-to-run-django-tests/
