CREATE TABLE IF NOT EXISTS fact_pilpres
(
    updated_at                          DateTime,

    kode_prov LowCardinality(String),
    nama_prov LowCardinality(String),
    kode_cab LowCardinality(String),
    nama_cab LowCardinality(String),
    kode_kec LowCardinality(String),
    nama_kec LowCardinality(String),
    kode_kel LowCardinality(String),
    nama_kel LowCardinality(String),
    kode_tps LowCardinality(String),
    nama_tps LowCardinality(String),

    `images` Array(String),
    `url_link` String,

    `total_suara_capres_01` UInt16,
    `total_suara_capres_02` UInt16,
    `total_suara_capres_03` UInt16,

    pemilih_dpt_j UInt16,
    pemilih_dpt_l UInt16,
    pemilih_dpt_p UInt16,
    pengguna_dpt_j UInt16,
    pengguna_dpt_l UInt16,
    pengguna_dpt_p UInt16,
    pengguna_dptb_j UInt16,
    pengguna_dptb_l UInt16,
    pengguna_dptb_p UInt16,
    pengguna_non_dpt_j UInt16,
    pengguna_non_dpt_l UInt16,
    pengguna_non_dpt_p UInt16,
    pengguna_total_j UInt16,
    pengguna_total_l UInt16,
    pengguna_total_p UInt16,
    suara_sah UInt16,
    suara_tidak_sah UInt16,
    suara_total UInt16,

    total_votes UInt16 MATERIALIZED total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03,

    tps_category String MATERIALIZED CASE
        WHEN kode_prov != '99' AND suara_sah = 0 AND (total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03) > 300 THEN 'Anomaly'
        WHEN kode_prov != '99' AND suara_sah > 0 AND suara_sah < (total_suara_capres_01 + total_suara_capres_02 + total_suara_capres_03) THEN 'Anomaly'
        ELSE 'Clean'
    END,

    INDEX idx_tps_category tps_category TYPE bloom_filter(0.01) GRANULARITY 1,
)
    ENGINE = ReplacingMergeTree
        PARTITION BY kode_prov
        ORDER BY (kode_prov, kode_cab, kode_kec, kode_kel, kode_tps)
        SETTINGS index_granularity = 8192;