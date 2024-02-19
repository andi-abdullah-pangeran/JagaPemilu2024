CREATE VIEW view_partai_summary AS
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
    kode_dapil,
    tps_partai_category,
    tps_category,
    CASE
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 1 THEN 'PKB'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 2 THEN 'Gerindra'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 3 THEN 'PDIP'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 4 THEN 'Golkar'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 5 THEN 'Nasdem'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 6 THEN 'Partai Buruh'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 7 THEN 'Partai Gelora'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 8 THEN 'PKS'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 9 THEN 'PKN'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 10 THEN 'Hanura'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 11 THEN 'Partai Garuda'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 12 THEN 'PAN'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 13 THEN 'PBB'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 14 THEN 'Demokrat'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 15 THEN 'PSI'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 16 THEN 'PERINDO'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 17 THEN 'PPP'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 18 THEN 'PNA'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 19 THEN 'Gabthat'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 20 THEN 'PDA'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 21 THEN 'Partai Aceh'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 22 THEN 'PAS Aceh'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 23 THEN 'SIRA'
        WHEN toInt16(metricsSummaryMap.metrics_key)  = 24 THEN 'Partai Ummat'
        ELSE 'UNKNOWN'
        END AS `partai`,
    sum(metricsSummaryMap.metrics_value) votes
FROM fact_pileg
         ARRAY JOIN metricsSummaryMap AS metricsSummaryMap
GROUP BY kode_prov,
         nama_prov,
         kode_cab,
         nama_cab,
         kode_kec,
         nama_kec,
         kode_kel,
         nama_kel,
         kode_tps,
         nama_tps,
         kode_dapil,
         tps_partai_category,
         tps_category,
         partai;
