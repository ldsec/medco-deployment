#!/bin/bash
set -Eeuo pipefail
# set up PM for medco

# generate password hashes
I2B2_SERVICE_PASSWORD_HASH=$(java -classpath "$JBOSS_HOME/I2b2PasswordHash/" I2b2PasswordHash "$I2B2_SERVICE_PASSWORD")
DEFAULT_USER_PASSWORD_HASH=$(java -classpath "$JBOSS_HOME/I2b2PasswordHash/" I2b2PasswordHash "$DEFAULT_USER_PASSWORD")

psql $PSQL_PARAMS -d "$I2B2_DB_NAME" <<-EOSQL
    -- database lookups
    INSERT INTO ONT_DB_LOOKUP(c_domain_id, c_project_path, c_owner_id, c_db_fullschema, c_db_datasource, c_db_servertype,
    c_db_nicename, c_db_tooltip, c_comment, c_entry_date, c_change_date, c_status_cd)
      VALUES('$I2B2_DOMAIN_NAME', 'MedCo/', '@', 'medco_ont', 'java:/MedCoOntDS', 'POSTGRESQL',
      'MedCo Ontology', NULL, NULL, NULL, NULL, NULL);
    INSERT INTO i2b2hive.CRC_DB_LOOKUP(c_domain_id, c_project_path, c_owner_id, c_db_fullschema, c_db_datasource,
    c_db_servertype, c_db_nicename, c_db_tooltip, c_comment, c_entry_date, c_change_date, c_status_cd)
      VALUES('$I2B2_DOMAIN_NAME', '/MedCo/encrypted/', '@', 'medco_encrypted_crc', 'java:/MedCoEncryptedCrcDS',
      'POSTGRESQL', 'MedCo Encrypted CRC', NULL, NULL, NULL, NULL, NULL);
    INSERT INTO i2b2hive.CRC_DB_LOOKUP(c_domain_id, c_project_path, c_owner_id, c_db_fullschema, c_db_datasource,
    c_db_servertype, c_db_nicename, c_db_tooltip, c_comment, c_entry_date, c_change_date, c_status_cd)
      VALUES('$I2B2_DOMAIN_NAME', '/MedCo/nonencrypted/', '@', 'medco_nonencrypted_crc', 'java:/MedCoNonEncryptedCrcDS',
      'POSTGRESQL', 'MedCo Non-Encrypted CRC', NULL, NULL, NULL, NULL, NULL);

    -- hive & users data
    insert into i2b2pm.pm_project_data (project_id, project_name, project_wiki, project_path, status_cd)
      values('MedCo', 'MedCo', 'https://medco.epfl.ch/documentation', '/MedCo', 'A'); --may not be needed
    insert into i2b2pm.pm_project_data (project_id, project_name, project_wiki, project_path, status_cd)
      values('MedCoEncrypted', 'MedCo Encrypted Data', 'https://medco.epfl.ch/documentation', '/MedCo/encrypted, 'A');
    insert into i2b2pm.pm_project_data (project_id, project_name, project_wiki, project_path, status_cd)
      values('MedCoNonEncrypted', 'MedCo Non-Encrypted Data', 'https://medco.epfl.ch/documentation', '/MedCo/nonencrypted', 'A');

    -- cell URLs
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://i2b2-medco:8080/i2b2/services/QueryToolService/' WHERE CELL_ID = 'CRC';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://i2b2-medco:8080/i2b2/services/FRService/' WHERE CELL_ID = 'FRC';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://i2b2-medco:8080/i2b2/services/OntologyService/' WHERE CELL_ID = 'ONT';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://i2b2-medco:8080/i2b2/services/WorkplaceService/' WHERE CELL_ID = 'WORK';
    UPDATE i2b2pm.PM_CELL_DATA SET URL = 'http://i2b2-medco:8080/i2b2/services/IMService/' WHERE CELL_ID = 'IM';

    INSERT INTO i2b2pm.PM_USER_DATA (USER_ID, FULL_NAME, PASSWORD, STATUS_CD)
        VALUES('medcoadmin', 'MedCo Admin', '$DEFAULT_USER_PASSWORD_HASH', 'A');
    INSERT INTO i2b2pm.PM_USER_DATA (USER_ID, FULL_NAME, PASSWORD, STATUS_CD)
        VALUES('medcouser', 'MedCo User', '$DEFAULT_USER_PASSWORD_HASH', 'A');

    INSERT INTO i2b2pm.PM_PROJECT_USER_ROLES (PROJECT_ID, USER_ID, USER_ROLE_CD, STATUS_CD) VALUES

        ('MedCo', 'AGG_SERVICE_ACCOUNT', 'USER', 'A'),
        ('MedCo', 'AGG_SERVICE_ACCOUNT', 'MANAGER', 'A'),
        ('MedCo', 'AGG_SERVICE_ACCOUNT', 'DATA_OBFSC', 'A'),
        ('MedCo', 'AGG_SERVICE_ACCOUNT', 'DATA_AGG', 'A'),
        ('MedCo', 'medcoadmin', 'MANAGER', 'A'),
        ('MedCo', 'medcoadmin', 'USER', 'A'),
        ('MedCo', 'medcoadmin', 'DATA_OBFSC', 'A'),
        ('MedCo', 'medcouser', 'USER', 'A'),
        ('MedCo', 'medcouser', 'DATA_DEID', 'A'),
        ('MedCo', 'medcouser', 'DATA_OBFSC', 'A'),
        ('MedCo', 'medcouser', 'DATA_AGG', 'A'),
        ('MedCo', 'medcouser', 'DATA_LDS', 'A'),
        ('MedCo', 'medcouser', 'EDITOR', 'A'),
        ('MedCo', 'medcouser', 'DATA_PROT', 'A'),

        ('MedCoEncrypted', 'AGG_SERVICE_ACCOUNT', 'USER', 'A'),
        ('MedCoEncrypted', 'AGG_SERVICE_ACCOUNT', 'MANAGER', 'A'),
        ('MedCoEncrypted', 'AGG_SERVICE_ACCOUNT', 'DATA_OBFSC', 'A'),
        ('MedCoEncrypted', 'AGG_SERVICE_ACCOUNT', 'DATA_AGG', 'A'),
        ('MedCoEncrypted', 'medcoadmin', 'MANAGER', 'A'),
        ('MedCoEncrypted', 'medcoadmin', 'USER', 'A'),
        ('MedCoEncrypted', 'medcoadmin', 'DATA_OBFSC', 'A'),
        ('MedCoEncrypted', 'medcouser', 'USER', 'A'),
        ('MedCoEncrypted', 'medcouser', 'DATA_DEID', 'A'),
        ('MedCoEncrypted', 'medcouser', 'DATA_OBFSC', 'A'),
        ('MedCoEncrypted', 'medcouser', 'DATA_AGG', 'A'),
        ('MedCoEncrypted', 'medcouser', 'DATA_LDS', 'A'),
        ('MedCoEncrypted', 'medcouser', 'EDITOR', 'A'),
        ('MedCoEncrypted', 'medcouser', 'DATA_PROT', 'A'),

        ('MedCoNonEncrypted', 'AGG_SERVICE_ACCOUNT', 'USER', 'A'),
        ('MedCoNonEncrypted', 'AGG_SERVICE_ACCOUNT', 'MANAGER', 'A'),
        ('MedCoNonEncrypted', 'AGG_SERVICE_ACCOUNT', 'DATA_OBFSC', 'A'),
        ('MedCoNonEncrypted', 'AGG_SERVICE_ACCOUNT', 'DATA_AGG', 'A'),
        ('MedCoNonEncrypted', 'medcoadmin', 'MANAGER', 'A'),
        ('MedCoNonEncrypted', 'medcoadmin', 'USER', 'A'),
        ('MedCoNonEncrypted', 'medcoadmin', 'DATA_OBFSC', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'USER', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'DATA_DEID', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'DATA_OBFSC', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'DATA_AGG', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'DATA_LDS', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'EDITOR', 'A'),
        ('MedCoNonEncrypted', 'medcouser', 'DATA_PROT', 'A'),

EOSQL
