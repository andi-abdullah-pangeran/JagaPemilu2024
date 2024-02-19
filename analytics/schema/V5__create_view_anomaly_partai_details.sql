CREATE VIEW view_anomaly_partai_details AS
SELECT a.kode_prov,
       a.nama_prov,
       a.kode_cab,
       a.nama_cab,
       a.kode_kec,
       a.nama_kec,
       a.kode_kel,
       a.nama_kel,
       a.kode_tps,
       a.nama_tps, a.votes sumPartai, b.votes sumPartaiVotesAndCaleg, (b.votes - a.votes) selisih,
       CASE
           WHEN toInt16(a.partai)  = 1 THEN 'PKB'
           WHEN toInt16(a.partai)  = 2 THEN 'Gerindra'
           WHEN toInt16(a.partai)  = 3 THEN 'PDIP'
           WHEN toInt16(a.partai)  = 4 THEN 'Golkar'
           WHEN toInt16(a.partai)  = 5 THEN 'Nasdem'
           WHEN toInt16(a.partai)  = 6 THEN 'Partai Buruh'
           WHEN toInt16(a.partai)  = 7 THEN 'Partai Gelora'
           WHEN toInt16(a.partai)  = 8 THEN 'PKS'
           WHEN toInt16(a.partai)  = 9 THEN 'PKN'
           WHEN toInt16(a.partai)  = 10 THEN 'Hanura'
           WHEN toInt16(a.partai)  = 11 THEN 'Partai Garuda'
           WHEN toInt16(a.partai)  = 12 THEN 'PAN'
           WHEN toInt16(a.partai)  = 13 THEN 'PBB'
           WHEN toInt16(a.partai)  = 14 THEN 'Demokrat'
           WHEN toInt16(a.partai)  = 15 THEN 'PSI'
           WHEN toInt16(a.partai)  = 16 THEN 'PERINDO'
           WHEN toInt16(a.partai)  = 17 THEN 'PPP'
           WHEN toInt16(a.partai)  = 18 THEN 'PNA'
           WHEN toInt16(a.partai)  = 19 THEN 'Gabthat'
           WHEN toInt16(a.partai)  = 20 THEN 'PDA'
           WHEN toInt16(a.partai)  = 21 THEN 'Partai Aceh'
           WHEN toInt16(a.partai)  = 22 THEN 'PAS Aceh'
           WHEN toInt16(a.partai)  = 23 THEN 'SIRA'
           WHEN toInt16(a.partai)  = 24 THEN 'Partai Ummat'
           ELSE 'UNKNOWN'
           END AS `partai`
FROM
    (SELECT
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
         metricsSummaryMap.metrics_key partai,
         sum(metricsSummaryMap.metrics_value) votes
     FROM fact_pileg a ARRAY JOIN metricsSummaryMap AS metricsSummaryMap
     WHERE tps_partai_category == 'Anomaly' AND tps_category == 'Clean'
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
         metricsSummaryMap.metrics_key) a
        INNER JOIN (SELECT
                        kode_tps,
                        kode_dapil,
                        metricsPartaiMap.metrics_key partai,
                        sum(metricsPartaiMap.metrics_value) votes
                    FROM fact_pileg a ARRAY JOIN metricsPartaiMap AS metricsPartaiMap
                    WHERE tps_partai_category == 'Anomaly' AND tps_category == 'Clean'
                    GROUP BY kode_tps,
                        kode_dapil,
                        metricsPartaiMap.metrics_key) b
                   ON (b.kode_tps = a.kode_tps AND a.partai = b.partai)
WHERE selisih > 0
