CREATE TABLE IF NOT EXISTS fact_pileg
(
    updated_at              DateTime,
    `images`                Array(String),
    `url_link`              String,

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
    kode_dapil LowCardinality(String),

    admin_pemilih_dpt_j           UInt16,
    admin_pemilih_dpt_l           UInt16,
    admin_pemilih_dpt_p           UInt16,
    admin_pengguna_dpt_j          UInt16,
    admin_pengguna_dpt_l          UInt16,
    admin_pengguna_dpt_p          UInt16,
    admin_pengguna_dptb_j         UInt16,
    admin_pengguna_dptb_l         UInt16,
    admin_pengguna_dptb_p         UInt16,
    admin_pengguna_non_dpt_j      UInt16,
    admin_pengguna_non_dpt_l      UInt16,
    admin_pengguna_non_dpt_p      UInt16,
    admin_pengguna_total_j        UInt16,
    admin_pengguna_total_l        UInt16,
    admin_pengguna_total_p        UInt16,
    admin_suara_sah               UInt16,
    admin_suara_tidak_sah         UInt16,
    admin_suara_total             UInt16,

    sum_metrics_partai             UInt16,
    sum_metrics_summary             UInt16,

    metricsPartaiMap Nested(
    metrics_key LowCardinality(String),
    metrics_value Int16
    ),

    metricsSummaryMap Nested(
    metrics_key LowCardinality(String),
    metrics_value Int16
    ),

    tps_partai_category String MATERIALIZED CASE
    WHEN abs(minus(sum_metrics_summary, sum_metrics_partai)) > 5 THEN 'Anomaly'
    ELSE 'Clean'
    END,

    tps_category String MATERIALIZED CASE
        WHEN kode_prov != '99' AND (admin_suara_sah = 0 AND (sum_metrics_partai > 300)) THEN 'Anomaly'
        WHEN kode_prov != '99' AND (admin_suara_sah > 0 AND ((abs(minus(admin_suara_sah, sum_metrics_summary)) > 5) OR (admin_suara_sah > 300))) THEN 'Anomaly'
        ELSE 'Clean'
    END
    )
    ENGINE = MergeTree
    PARTITION BY kode_prov
    ORDER BY (kode_prov, kode_cab, kode_kec, kode_kel, kode_tps)
    SETTINGS index_granularity = 8192;
