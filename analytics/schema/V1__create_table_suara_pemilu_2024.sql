CREATE TABLE IF NOT EXISTS suara_pemilu_2024
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
    suara_total UInt16
)
    ENGINE = ReplacingMergeTree
        PARTITION BY kode_prov
        ORDER BY (kode_prov, kode_cab, kode_kec, kode_kel, kode_tps)
        SETTINGS index_granularity = 8192;