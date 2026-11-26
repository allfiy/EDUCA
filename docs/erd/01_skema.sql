-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 26, 2026 at 02:34 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `educa`
--

-- --------------------------------------------------------

--
-- Table structure for table `diskusi`
--

CREATE TABLE `diskusi` (
  `id_diskusi` int NOT NULL,
  `id_pelajar` int NOT NULL,
  `id_topik` int NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` text NOT NULL,
  `waktu_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jawaban_pelajar`
--

CREATE TABLE `jawaban_pelajar` (
  `id_percobaan` int NOT NULL,
  `id_pertanyaan` int NOT NULL,
  `id_pilihan` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `latihan_soal`
--

CREATE TABLE `latihan_soal` (
  `id_latihan` int NOT NULL,
  `id_topik` int NOT NULL,
  `judul` varchar(200) NOT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mata_pelajaran`
--

CREATE TABLE `mata_pelajaran` (
  `id_mapel` int NOT NULL,
  `nama_mapel` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materi`
--

CREATE TABLE `materi` (
  `id_materi` int NOT NULL,
  `id_topik` int NOT NULL,
  `judul` varchar(200) NOT NULL,
  `isi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pelajar`
--

CREATE TABLE `pelajar` (
  `id_pelajar` int NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `kata_sandi` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `percobaan_latihan`
--

CREATE TABLE `percobaan_latihan` (
  `id_percobaan` int NOT NULL,
  `id_pelajar` int NOT NULL,
  `id_latihan` int NOT NULL,
  `waktu_mulai` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `waktu_kirim` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `pertanyaan`
--

CREATE TABLE `pertanyaan` (
  `id_pertanyaan` int NOT NULL,
  `id_latihan` int NOT NULL,
  `teks_pertanyaan` text NOT NULL,
  `pembahasan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pilihan_jawaban`
--

CREATE TABLE `pilihan_jawaban` (
  `id_pilihan` int NOT NULL,
  `id_pertanyaan` int NOT NULL,
  `teks_pilihan` varchar(500) NOT NULL,
  `is_benar` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tanggapan_diskusi`
--

CREATE TABLE `tanggapan_diskusi` (
  `id_tanggapan` int NOT NULL,
  `id_diskusi` int NOT NULL,
  `id_pelajar` int NOT NULL,
  `isi` text NOT NULL,
  `waktu_dibuat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `topik`
--

CREATE TABLE `topik` (
  `id_topik` int NOT NULL,
  `id_mapel` int NOT NULL,
  `nama_topik` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `diskusi`
--
ALTER TABLE `diskusi`
  ADD PRIMARY KEY (`id_diskusi`),
  ADD KEY `fk_diskusi_pelajar` (`id_pelajar`),
  ADD KEY `fk_diskusi_topik` (`id_topik`);

--
-- Indexes for table `jawaban_pelajar`
--
ALTER TABLE `jawaban_pelajar`
  ADD PRIMARY KEY (`id_percobaan`,`id_pertanyaan`),
  ADD KEY `fk_jawaban_pertanyaan` (`id_pertanyaan`),
  ADD KEY `fk_jawaban_pilihan_pertanyaan` (`id_pilihan`,`id_pertanyaan`);

--
-- Indexes for table `latihan_soal`
--
ALTER TABLE `latihan_soal`
  ADD PRIMARY KEY (`id_latihan`),
  ADD KEY `fk_latihan_topik` (`id_topik`);

--
-- Indexes for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  ADD PRIMARY KEY (`id_mapel`),
  ADD UNIQUE KEY `nama_mapel` (`nama_mapel`);

--
-- Indexes for table `materi`
--
ALTER TABLE `materi`
  ADD PRIMARY KEY (`id_materi`),
  ADD KEY `fk_materi_topik` (`id_topik`);

--
-- Indexes for table `pelajar`
--
ALTER TABLE `pelajar`
  ADD PRIMARY KEY (`id_pelajar`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `percobaan_latihan`
--
ALTER TABLE `percobaan_latihan`
  ADD PRIMARY KEY (`id_percobaan`),
  ADD KEY `fk_percobaan_pelajar` (`id_pelajar`),
  ADD KEY `fk_percobaan_latihan` (`id_latihan`);

--
-- Indexes for table `pertanyaan`
--
ALTER TABLE `pertanyaan`
  ADD PRIMARY KEY (`id_pertanyaan`),
  ADD KEY `fk_pertanyaan_latihan` (`id_latihan`);

--
-- Indexes for table `pilihan_jawaban`
--
ALTER TABLE `pilihan_jawaban`
  ADD PRIMARY KEY (`id_pilihan`),
  ADD UNIQUE KEY `id_pilihan` (`id_pilihan`,`id_pertanyaan`),
  ADD KEY `fk_pilihan_pertanyaan` (`id_pertanyaan`);

--
-- Indexes for table `tanggapan_diskusi`
--
ALTER TABLE `tanggapan_diskusi`
  ADD PRIMARY KEY (`id_tanggapan`),
  ADD KEY `fk_tanggapan_diskusi` (`id_diskusi`),
  ADD KEY `fk_tanggapan_pelajar` (`id_pelajar`);

--
-- Indexes for table `topik`
--
ALTER TABLE `topik`
  ADD PRIMARY KEY (`id_topik`),
  ADD KEY `fk_topik_mapel` (`id_mapel`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `diskusi`
--
ALTER TABLE `diskusi`
  MODIFY `id_diskusi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `latihan_soal`
--
ALTER TABLE `latihan_soal`
  MODIFY `id_latihan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  MODIFY `id_mapel` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `materi`
--
ALTER TABLE `materi`
  MODIFY `id_materi` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pelajar`
--
ALTER TABLE `pelajar`
  MODIFY `id_pelajar` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `percobaan_latihan`
--
ALTER TABLE `percobaan_latihan`
  MODIFY `id_percobaan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pertanyaan`
--
ALTER TABLE `pertanyaan`
  MODIFY `id_pertanyaan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pilihan_jawaban`
--
ALTER TABLE `pilihan_jawaban`
  MODIFY `id_pilihan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tanggapan_diskusi`
--
ALTER TABLE `tanggapan_diskusi`
  MODIFY `id_tanggapan` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `topik`
--
ALTER TABLE `topik`
  MODIFY `id_topik` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `diskusi`
--
ALTER TABLE `diskusi`
  ADD CONSTRAINT `fk_diskusi_pelajar` FOREIGN KEY (`id_pelajar`) REFERENCES `pelajar` (`id_pelajar`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_diskusi_topik` FOREIGN KEY (`id_topik`) REFERENCES `topik` (`id_topik`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `jawaban_pelajar`
--
ALTER TABLE `jawaban_pelajar`
  ADD CONSTRAINT `fk_jawaban_percobaan` FOREIGN KEY (`id_percobaan`) REFERENCES `percobaan_latihan` (`id_percobaan`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jawaban_pertanyaan` FOREIGN KEY (`id_pertanyaan`) REFERENCES `pertanyaan` (`id_pertanyaan`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_jawaban_pilihan_pertanyaan` FOREIGN KEY (`id_pilihan`,`id_pertanyaan`) REFERENCES `pilihan_jawaban` (`id_pilihan`, `id_pertanyaan`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `latihan_soal`
--
ALTER TABLE `latihan_soal`
  ADD CONSTRAINT `fk_latihan_topik` FOREIGN KEY (`id_topik`) REFERENCES `topik` (`id_topik`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `materi`
--
ALTER TABLE `materi`
  ADD CONSTRAINT `fk_materi_topik` FOREIGN KEY (`id_topik`) REFERENCES `topik` (`id_topik`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `percobaan_latihan`
--
ALTER TABLE `percobaan_latihan`
  ADD CONSTRAINT `fk_percobaan_latihan` FOREIGN KEY (`id_latihan`) REFERENCES `latihan_soal` (`id_latihan`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_percobaan_pelajar` FOREIGN KEY (`id_pelajar`) REFERENCES `pelajar` (`id_pelajar`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `pertanyaan`
--
ALTER TABLE `pertanyaan`
  ADD CONSTRAINT `fk_pertanyaan_latihan` FOREIGN KEY (`id_latihan`) REFERENCES `latihan_soal` (`id_latihan`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `pilihan_jawaban`
--
ALTER TABLE `pilihan_jawaban`
  ADD CONSTRAINT `fk_pilihan_pertanyaan` FOREIGN KEY (`id_pertanyaan`) REFERENCES `pertanyaan` (`id_pertanyaan`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `tanggapan_diskusi`
--
ALTER TABLE `tanggapan_diskusi`
  ADD CONSTRAINT `fk_tanggapan_diskusi` FOREIGN KEY (`id_diskusi`) REFERENCES `diskusi` (`id_diskusi`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tanggapan_pelajar` FOREIGN KEY (`id_pelajar`) REFERENCES `pelajar` (`id_pelajar`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `topik`
--
ALTER TABLE `topik`
  ADD CONSTRAINT `fk_topik_mapel` FOREIGN KEY (`id_mapel`) REFERENCES `mata_pelajaran` (`id_mapel`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
