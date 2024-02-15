CREATE VIEW view_candidate_analysis_summary AS
SELECT
    vcs.kode_prov,
    vcs.nama_prov,
    vcs.kode_cab,
    vcs.nama_cab,
    vcs.kode_kec,
    vcs.nama_kec,
    vcs.kode_kel,
    vcs.nama_kel,
    vcs.kode_tps,
    vcs.nama_tps,
    vcs.candidate,
    vcs.total_suara,
    vccs.total_suara AS total_clean_suara,
    (vcs.total_suara - vccs.total_suara) total_diff
FROM view_candidate_summary vcs
         LEFT JOIN view_candidate_clean_summary vccs
                   ON (vcs.candidate = vccs.candidate
                       AND vcs.kode_prov = vccs.kode_prov
                       AND vcs.nama_prov = vccs.nama_prov
                       AND vcs.kode_cab = vccs.kode_cab
                       AND vcs.nama_cab = vccs.nama_cab
                       AND vcs.kode_kec = vccs.kode_kec
                       AND vcs.nama_kec = vccs.nama_kec
                       AND vcs.kode_kel = vccs.kode_kel
                       AND vcs.nama_kel = vccs.nama_kel
                       AND vcs.kode_tps = vccs.kode_tps
                       AND vcs.nama_tps = vccs.nama_tps
                       )