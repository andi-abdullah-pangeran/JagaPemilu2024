CREATE VIEW view_summary AS
SELECT
    kode_prov,
    nama_prov,
    kode_cab,
    nama_cab,
    kode_kec,
    nama_kec,
    kode_kel,
    nama_kel,
    kode_tps,
    nama_tps,
    SUM(total_suara_capres_01) AS total_suara_capres_01,
    SUM(total_suara_capres_02) AS total_suara_capres_02,
    SUM(total_suara_capres_03) AS total_suara_capres_03,
    total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03 AS total_votes
FROM
    suara_pemilu_2024
GROUP BY kode_prov,nama_prov, kode_cab, nama_cab, kode_kec, nama_kec, kode_kel, nama_kel, kode_tps, nama_tps;