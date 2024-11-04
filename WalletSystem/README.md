1. Struktur Aplikasi
Aplikasi ini memerlukan:

Backend API dengan Ruby on Rails (RoR) untuk menangani transaksi dompet, relasi antar entitas (misalnya, User, Team, Stock), dan logika transaksi.
Frontend menggunakan JavaScript untuk antarmuka pengguna, di mana pengguna dapat memeriksa saldo, membuat transaksi, dan mengakses harga saham terbaru.
2. Fitur Utama dan Detail Implementasi
Berikut adalah rincian fitur-fitur yang diminta:

a. Sistem Dompet (Wallet System)
Setiap entitas (misalnya, User, Team, Stock) akan memiliki dompet masing-masing untuk menampung saldo yang dapat diisi (kredit) atau dikurangi (debit). Implementasi:

Model Dompet: Membuat model Wallet untuk setiap entitas.
Relasi: Menggunakan relasi has_one atau belongs_to antara entitas dan model Wallet.
Transaksi Dompet: Model Transaction dengan validasi yang memeriksa sumber dan tujuan transaksi (contohnya, jika credit maka source_wallet kosong, jika debit maka target_wallet kosong).
b. Validasi Transaksi
Setiap transaksi harus tervalidasi dengan ketat. Validasi meliputi:

Sumber dan Tujuan: Menentukan dari mana uang diambil dan ke mana ditransfer.
ACID Compliance: Menggunakan ActiveRecord transaction untuk memastikan setiap transaksi memenuhi standar ACID (Atomicity, Consistency, Isolation, Durability).
c. Pola Desain untuk Manipulasi Uang
Gunakan Single Table Inheritance (STI) atau pola desain lain untuk memastikan semua transaksi dan operasi dompet dapat dikelola secara konsisten. Misalnya, buat kelas dasar Transaction dan sub-kelas CreditTransaction dan DebitTransaction untuk menangani tipe transaksi yang berbeda.

d. Autentikasi Tanpa Eksternal Gem
Untuk sesi login:

Session Management: Implementasi login kustom di controller untuk membuat sesi dan menyimpan data pengguna.
Keamanan: Validasi token atau session ID untuk memastikan setiap permintaan dilakukan oleh pengguna yang sah.
e. Library Harga Saham Terbaru
Buat library di folder lib dengan format gem-style bernama LatestStockPrice, dengan fungsi untuk mengakses tiga endpoint:

price: Mendapatkan harga terbaru dari satu saham.
prices: Mendapatkan harga dari beberapa saham tertentu.
price_all: Mendapatkan harga semua saham.
API Integration: Gunakan API dari RapidAPI untuk mendapatkan data harga saham.
3. Struktur Database
Implementasikan skema database seperti berikut:

Tables:
users, teams, stocks: Menyimpan data dasar entitas.
wallets: Menyimpan saldo untuk masing-masing entitas dengan relasi ke user_id, team_id, atau stock_id.
transactions: Menyimpan setiap transaksi dompet dengan informasi sumber, tujuan, jumlah, dan tipe transaksi.
4. API dan Endpoint
Buat endpoint RESTful untuk mendukung transaksi berikut:

POST /login: Endpoint untuk login dan membuat sesi pengguna.
GET /wallets/
: Mendapatkan saldo dompet untuk entitas tertentu.
POST /transactions: Membuat transaksi baru (baik debit atau kredit) antara dua entitas.
GET /stocks/
/price: Menggunakan library LatestStockPrice untuk mendapatkan harga saham tertentu.
5. Antarmuka Pengguna (Frontend)
Frontend diimplementasikan dengan JavaScript (misalnya, React atau Vue.js), dengan beberapa fitur utama:

Dashboard Saldo: Menampilkan saldo dompet setiap entitas.
Formulir Transaksi: Memungkinkan pengguna untuk mengirim uang antar dompet.
Cek Harga Saham: Antarmuka untuk mengambil dan menampilkan harga saham terkini.
