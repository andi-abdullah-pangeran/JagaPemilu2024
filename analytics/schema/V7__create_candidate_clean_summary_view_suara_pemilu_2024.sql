CREATE VIEW view_candidate_clean_summary AS
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
    '01' AS candidate,
    SUM(total_suara_capres_01) AS total_suara
FROM
    view_clean_summary
GROUP BY kode_prov,nama_prov, kode_cab, nama_cab, kode_kec, nama_kec, kode_kel, nama_kel, kode_tps, nama_tps
UNION ALL
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
    '02' AS candidate,
    SUM(total_suara_capres_02) AS total_suara
FROM
    view_clean_summary
GROUP BY kode_prov,nama_prov, kode_cab, nama_cab, kode_kec, nama_kec, kode_kel, nama_kel, kode_tps, nama_tps
UNION ALL
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
    '03' AS candidate,
    SUM(total_suara_capres_03) AS total_suara
FROM
    view_clean_summary
GROUP BY kode_prov,nama_prov, kode_cab, nama_cab, kode_kec, nama_kec, kode_kel, nama_kel, kode_tps, nama_tps