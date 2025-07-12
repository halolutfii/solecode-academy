CREATE DATABASE siperpus;

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat TEXT NOT NULL,
    no_ktp VARCHAR(20) NOT NULL,
    no_hp VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    tanggal_terdaftar DATE NOT NULL DEFAULT (CURDATE())
);

CREATE TABLE Kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(50) NOT NULL
);

CREATE TABLE Buku (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(255) NOT NULL,
    pengarang VARCHAR(100) NOT NULL,
    penerbit VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    tahun_terbit YEAR NOT NULL,
    jumlah_tersedia INT NOT NULL,
    kategori_id INT,
    FOREIGN KEY (kategori_id) REFERENCES Kategori(id)
);

CREATE TABLE Peminjaman (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anggota_id INT,
    buku_id INT,
    tanggal_pinjam DATE NOT NULL,
    tanggal_batas_kembali DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0,
    FOREIGN KEY (anggota_id) REFERENCES User(id),
    FOREIGN KEY (buku_id) REFERENCES Buku(id)
);

-- Initial Data
-- Masukkan data 5 Kategori ke dalam sistem
INSERT INTO kategori ('id', 'nama') VALUES 
('1', 'ACTION'),
('2', 'SCI-FI'),
('3', 'ROMANCE'),
('4', 'HORROR'),
('5', 'COMEDY');

-- Masukkan data 5 User ke dalam sistem
INSERT INTO user (id, nama, alamat, no_ktp, no_hp, email, tanggal_terdaftar) VALUES
('6', 'Lutfi', 'Alamat 1', '3674011245822231', '082110833753', 'lutfii@gmail.com', '2025-07-12'),
('7', 'Cahya', 'Alamat 2', '3674011245822231', '082110833753', 'cahya@gmail.com', '2025-07-12'),
('8', 'Nugraha', 'Alamat 3', '3674011245822231', '082110833753', 'nugraha@gmail.com', '2025-07-12'),
('9', 'Lutfi Cahya', 'Alamat 4', '3674011245822231', '082110833753', 'lutfiicahya@gmail.com', '2025-07-12'),
('10', 'Lutfi cahya Nugraha', 'Alamat 5', '3674011245822231', '082110833753', 'lutfiicahyan@gmail.com', '2025-07-12');

-- Masukkan data 10 Buku ke dalam sistem
INSERT INTO buku (judul, pengarang, penerbit, isbn, tahun_terbit, jumlah_tersedia, kategori_id) VALUES
('Laskar Pelangi', 'Andrea Hirata', 'Bentang Pustaka', '9789791227202', 2005, 10, 3),
('The Martian', 'Andy Weir', 'Crown Publishing', '9780804139021', 2014, 5, 2),
('Dilan 1990', 'Pidi Baiq', 'Pastel Books', '9786027870418', 2014, 7, 3),
('Harry Potter and the Philosopher\"s Stone', 'J.K. Rowling', 'Bloomsbury', '9780747532699', 1997, 6, 1),
('It', 'Stephen King', 'Viking Press', '9780450411434', 1986, 4, 4),
('The Shining', 'Stephen King', 'Doubleday', '9780385121675', 1977, 3, 4),
('Ketawa Bareng Komika', 'Raditya Dika', 'GagasMedia', '9789797808597', 2010, 8, 5),
('Ready Player One', 'Ernest Cline', 'Crown Publishing', '9780307887436', 2011, 5, 2),
('Attack on Titan', 'Hajime Isayama', 'Kodansha', '9781612620244', 2009, 9, 1),
('Surat Kecil untuk Tuhan', 'Agnes Davonar', 'Inandra Published', '9786029787271', 2011, 4, 3);

-- Masukkan 9 data peminjaman
INSERT INTO peminjaman (id, anggota_id, buku_id, tanggal_pinjam, tanggal_batas_kembali, tanggal_kembali, denda) VALUES 
('1', '1', '1', '2025-07-12', '2025-07-14', NULL, NULL),
('2', '1', '2', '2025-07-12', '2025-07-14', NULL, NULL),
('3', '1', '3', '2025-07-12', '2025-07-14', NULL, NULL),
('4', '2', '4', '2025-07-12', '2025-07-14', NULL, NULL),
('5', '2', '5', '2025-07-12', '2025-07-14', NULL, NULL),
('6', '2', '6', '2025-07-12', '2025-07-14', NULL, NULL),
('7', '3', '7', '2025-07-12', '2025-07-14', NULL, NULL),
('8', '3', '8', '2025-07-12', '2025-07-14', NULL, NULL),
('9', '3', '9', '2025-07-12', '2025-07-14', NULL, NULL);

-- User 3 terlambat mengembalikan 1 Buku (5 hari)
UPDATE peminjaman SET tanggal_kembali = '2025-07-13' WHERE id IN (1,2,3,4,5,6,7,8);
UPDATE peminjaman SET tanggal_kembali = '2025-07-19', denda = 5000 WHERE id = 9;

-- Manipulasi Data
-- Tampilkan daftar buku yang tidak pernah dipinjam di oleh siapapun. (Expected output buku ke-10)
SELECT * FROM buku LEFT JOIN peminjaman ON buku.id = peminjaman.buku_id WHERE peminjaman.buku_id IS NULL;

-- Tampilkan user yang pernah mengembalikan buku terlambat beserta dendanya. (Expected output user 3 dan denda Rp5.000)
SELECT user.id, user.nama, peminjaman.denda FROM peminjaman JOIN user ON peminjaman.anggota_id  = user.id 
WHERE peminjaman.denda IS NOT NULL AND peminjaman.denda > 0;

-- Tampilkan user 1 (Lutfi) dengan daftar buku yang dipinjam nya.
SELECT 1 AS 'No', user.nama AS User, GROUP_CONCAT(buku.judul ORDER BY buku.id ASC SEPARATOR ', ') AS 'Buku'
FROM peminjaman
JOIN user ON peminjaman.anggota_id = user.id
JOIN buku ON peminjaman.buku_id = buku.id
WHERE user.id = 1
GROUP BY user.id;