CREATE VIEW view_clean_suara AS
SELECT
    *
FROM
    suara_pemilu_2024
WHERE
    (kode_prov != '99' AND suara_sah = 0 AND (total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03) <= 300)
   OR
    (kode_prov != '99' AND  suara_sah > 0 AND suara_sah >= (total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03));