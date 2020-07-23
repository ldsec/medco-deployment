#!/bin/bash
set -Eeuo pipefail
# set up common medco ontology

psql $PSQL_PARAMS -d "$I2B2_DB_NAME" <<-EOSQL

    -- add encrypted dummy flags for medco_encrypted_crc.patient_dimension
    ALTER TABLE medco_encrypted_crc.patient_dimension ADD COLUMN enc_dummy_flag_cd character(88);
    COMMENT ON COLUMN medco_encrypted_crc.patient_dimension.enc_dummy_flag_cd IS 'base64-encoded encrypted dummy flag (0 or 1)';
    INSERT INTO medco_encrypted_crc.code_lookup VALUES
        ('patient_dimension', 'enc_dummy_flag_cd', 'CRC_COLUMN_DESCRIPTOR', 'Encrypted Dummy Flag', NULL, NULL, NULL,
        NULL, 'NOW()', NULL, 1);

    -- add encrypted patient id flags for medco_encrypted_crc.patient_dimension in crc schema
    ALTER TABLE medco_encrypted_crc.patient_dimension ADD COLUMN enc_real_pseudonym_cd bytea;
    COMMENT ON COLUMN medco_encrypted_crc.patient_dimension.enc_real_pseudonym_cd IS 'binary encrypted real pseudonym of patient (or 0 if dummy)';
    INSERT INTO medco_encrypted_crc.code_lookup VALUES
        ('patient_dimension', 'enc_real_pseudonym_cd', 'CRC_COLUMN_DESCRIPTOR', 'Encrypted Real Pseudonym Flag', NULL, NULL, NULL,
        NULL, 'NOW()', NULL, 1);

EOSQL
