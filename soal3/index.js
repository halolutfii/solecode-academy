const tanggalPinjam = "2024-07-12";
const tanggalKembali = "2024-07-31"; // Terlambat 5 hari
const daftarBuku = [
  { id: "BOOK001", title: "Pemrograman JavaScript" },
  { id: "BOOK002", title: "Algoritma dan Struktur Data" },
  { id: "BOOK003", title: "Basis Data Lanjut" }
];
const batasMaxPinjaman = 14;  // 14 hari
const dendaHarian = 1000;     // Rp 1000/hari

function hitungDenda(tanggalKembali, tanggalPinjam, daftarBuku, batasHari, dendaPerHari) {
  const MS_PER_DAY = 1000 * 60 * 60 * 24;

  const kembali = new Date(tanggalKembali);
  const pinjam = new Date(tanggalPinjam);

  const durasi = Math.ceil((kembali - pinjam) / MS_PER_DAY);
  const terlambat = Math.max(0, durasi - batasHari);
  const totalDenda = terlambat * dendaPerHari;

  return daftarBuku.map(buku => ({
    title: buku.title,
    denda: totalDenda
  }));
}

const hasilDenda = hitungDenda(tanggalKembali, tanggalPinjam, daftarBuku, batasMaxPinjaman, dendaHarian);

console.log(hasilDenda);

hasilDenda.forEach(item => {
  console.log(`${item.title} = Rp. ${item.denda}`);
});