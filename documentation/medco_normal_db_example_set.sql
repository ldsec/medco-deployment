-- all the metadata, using the values parsed
-- check how to make link with dataset (desc it, use email sent before)

-- schema i2b2metadata: ontology cell (ONT)
-- schema i2b2demodata: data repository cell (CRC)

-- add the things that must be modified in queries
--todo: get into md file for documentation, dataloading.md

-- warning about confusion: poatient_id != sample_id in i2b2, but same in 95% of dataset
-- name of fields: the 6th row for clinical, 2nd for genomic

-- loading
-- 1. ontology in i2b2metadata.{clinical_sensitive, clinical_non_sensitive, genomic} + i2b2demodata.concept_dimension
-- 2. patients + samples in i2b2demodata.{patient_mapping, encounter_mapping, patient_dimension, visit_dimension} + provider_dimension
-- 3. data in observation_fact

------------------------------------------------------------------------------------------------------------------------
-----SCHEMA i2b2metadata------------------------------------------------------------------------------------------------
-----TABLE clinical_sensitive-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- ontology data for sensitive clinical attributes, from the clinical dataset
--- example with 2 clinical fields classified as sensitive (PRIMARY_TUMOR_LOCALIZATION_TYPE and CANCER_TYPE_DETAILED)

-- 1 entry per field (= 2), level 3
INSERT INTO i2b2metadata.clinical_sensitive VALUES (3, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\', 'PRIMARY_TUMOR_LOCALIZATION_TYPE', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\', 'Sensitive field encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (3, '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\', 'CANCER_TYPE_DETAILED', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\', 'Sensitive field encrypted by Unlynx', '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);

-- 1 entry per different value occurring for each field (= 5 + 1), level 4
-- c_basecode column is of the form "C_ENC:X", with X being an integer > 1 that is incremental, with each value
-- having such a unique ID within all the C_ENC values, it is this ID that is encrypted
-- notice the special "<empty>" value, which for when there is no value at all in the dataset
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Mucosal\\', 'Mucosal', 'N', 'LA ', NULL, 'C_ENC:1', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Mucosal\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Mucosal\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\<empty>\\', '<empty>', 'N', 'LA ', NULL, 'C_ENC:2', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\<empty>\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\<empty>\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Acral\\', 'Acral', 'N', 'LA ', NULL, 'C_ENC:3', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Acral\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Acral\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Skin\\', 'Skin', 'N', 'LA ', NULL, 'C_ENC:4', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Skin\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Skin\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Uveal\\', 'Uveal', 'N', 'LA ', NULL, 'C_ENC:5', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Uveal\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\PRIMARY_TUMOR_LOCALIZATION_TYPE\\Uveal\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_sensitive VALUES (4, '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\Cutaneous Melanoma\\', 'Cutaneous Melanoma', 'N', 'LA ', NULL, 'C_ENC:6', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\Cutaneous Melanoma\\', 'Sensitive value encrypted by Unlynx', '\\medco\\clinical\\sensitive\\CANCER_TYPE_DETAILED\\Cutaneous Melanoma\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);


------------------------------------------------------------------------------------------------------------------------
-----TABLE clinical_non_sensitive---------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- ontology data for non-sensitive clinical attributes, from the clinical dataset
--- example with 2 clinical fields classified as non sensitive (CANCER_TYPE and PRIMARY_DIAGNOSIS)

-- 1 entry per field (= 2), level 3
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (3, '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\', 'CANCER_TYPE', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\', 'Non-sensitive field', '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (3, '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\', 'PRIMARY_DIAGNOSIS', 'N', 'CA ', NULL, NULL, NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\', 'Non-sensitive field', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);

-- 1 entry per different value occurring for each field (= 3 + 1), level 4
-- c_basecode column is of the form "CLEAR:X", with X being an integer > 1 that is incremental, with each value
-- having such a unique ID within all the CLEAR values
-- notice the special "<empty>" value, which for when there is no value at all in the dataset
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (4, '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\Melanoma\\', 'Melanoma', 'N', 'LA ', NULL, 'CLEAR:1', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\Melanoma\\', 'Non-sensitive value', '\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\Melanoma\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (4, '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Melanoma\\', 'Melanoma', 'N', 'LA ', NULL, 'CLEAR:2', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Melanoma\\', 'Non-sensitive value', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Melanoma\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (4, '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\<empty>\\', '<empty>', 'N', 'LA ', NULL, 'CLEAR:3', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\<empty>\\', 'Non-sensitive value', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\<empty>\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);
INSERT INTO i2b2metadata.clinical_non_sensitive VALUES (4, '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Not Melanoma\\', 'Not Melanoma', 'N', 'LA ', NULL, 'CLEAR:4', NULL, 'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Not Melanoma\\', 'Non-sensitive value', '\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Not Melanoma\\', 'NOW()', NULL, NULL, NULL, 'CLEAR', '@', NULL, NULL, NULL, NULL);


------------------------------------------------------------------------------------------------------------------------
-----TABLE genomic------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- ontology data for genomic attributes, from the genomic dataset
--- example with 1 annotation (i.e. 1 column) named Protein_Position
--- there are 1 entry for the dataset itself (level 2), and as many entries (level 3) as there are annotations (here just one)

-- escape XML values + escape for csv encoding
-- see class server/ch/epfl/lca1/medco/loader/genomic/GenomicLoader.java, methods genXmlAnnotationsMetadata() and genXmlAnnotationsValues() for the XML format
INSERT INTO i2b2metadata.genomic VALUES (2, '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\', 'Genomic Annotations (skcm_broad)', 'N', 'CA ', NULL, NULL,
    '<genomic_annotations_metadata> <annotations_name><name>Protein_Position</name></annotations_name> <nb_variants>456998</nb_variants> <assay_information>???</assay_information> <variant_ids>X,Y,Z</variant_ids> </genomic_annotations_metadata>',
    'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\', 'Genomic annotations and sample data', '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);

INSERT INTO i2b2metadata.genomic VALUES (3, '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\Protein_Position\\', 'Protein_Position', 'N', 'LA ', NULL, NULL,
    '<genomic_annotations_values>X,Y,Z</genomic_annotations_values>',
    'concept_cd', 'concept_dimension', 'concept_path', 'T', 'LIKE', '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\Protein_Position\\', 'Genomic annotations and sample data', '\\medco\\genomic\\Genomic_Annotations_skcm_broad\\Protein_Position\\', 'NOW()', NULL, NULL, NULL, 'C_ENC', '@', NULL, NULL, NULL, NULL);



------------------------------------------------------------------------------------------------------------------------
-----SCHEMA i2b2demodata------------------------------------------------------------------------------------------------
-----TABLE concept_dimension--------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- reduced set of ontology data specific to the CRC, that is joined to the observation_fact table to answer queries
-- contains the clear concept the same way they are in the ontology
-- for the sensitive ones it contains the tagged identifiers
--- example follows what is in the ontology cell

-- clear-text concepts (clinical non-sensitive)
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\clinical\\nonsensitive\\CANCER_TYPE\\Melanoma\\', 'CLEAR:1', 'Melanoma', NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Melanoma\\', 'CLEAR:2', 'Melanoma', NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\<empty>\\', 'CLEAR:3', '<empty>', NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\clinical\\nonsensitive\\PRIMARY_DIAGNOSIS\\Not Melanoma\\', 'CLEAR:4', 'Not Melanoma', NULL, NULL, NULL, 'NOW()', NULL, NULL);

-- tagged concepts (both clinical sensitive and genomic)
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\EkaojcPm7U3qsQp0bhzaLZLYenL/+yNS5j39TFcLU1u=\\', 'TAG:EkaojcPm7U3qsQp0bhzaLZLYenL/+yNS5j39TFcLU1u=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\BMSfLSsNrDeTssfy57z5DfT8V/4u9cE7UWFjgBPpu7y=\\', 'TAG:BMSfLSsNrDeTssfy57z5DfT8V/4u9cE7UWFjgBPpu7y=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\eTssfFjgBPBMSfLSsNrDpu7yy57z5DfT8V/4u9cE7UW=\\', 'TAG:eTssfFjgBPBMSfLSsNrDpu7yy57z5DfT8V/4u9cE7UW=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\U3qsQp0bhzaEkaojcP39TFcLU1um7LZLYenL/+yNS5j=\\', 'TAG:U3qsQp0bhzaEkaojcP39TFcLU1um7LZLYenL/+yNS5j=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\8V/4u9cE7UWFjgBPpu7yBMSfLSsNrDeTssfy57z5DfT=\\', 'TAG:8V/4u9cE7UWFjgBPpu7yBMSfLSsNrDeTssfy57z5DfT=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);
INSERT INTO i2b2demodata.concept_dimension VALUES ('\\medco\\tagged\\WFjgBPpu7yBMSfLSsNrDeTs8V/sfy57z5DfT4u9cE7U=\\', 'TAG:WFjgBPpu7yBMSfLSsNrDeTs8V/sfy57z5DfT4u9cE7U=', NULL, NULL, NULL, NULL, 'NOW()', NULL, NULL);


------------------------------------------------------------------------------------------------------------------------
-----TABLE patient_mapping----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- mappings of patient identifiers: internal i2b2 id (patient_num column) <-> external id (patient_ide)
-- if the external source (patient_ide_source) has the special value of "HIVE", it means the corresponding id is the i2b2 internal one
-- (every patient registered in i2b2 has such a record)
--- example with 2 patients: "MEL-Ma-Mel-103b" (patient_num = 40) and "MEL-Ma-Mel-102" (patient_num = 39) => 1 patient = 2 entries

-- entries containing the identifiers from the external source (here the source is defined as "chuv")
INSERT INTO i2b2demodata.patient_mapping VALUES ('MEL-Ma-Mel-103b', 'chuv', 40, NULL, 'Demo', NULL, NULL, NULL, 'NOW()', NULL, 1);
INSERT INTO i2b2demodata.patient_mapping VALUES ('MEL-Ma-Mel-102', 'chuv', 39, NULL, 'Demo', NULL, NULL, NULL, 'NOW()', NULL, 1);

-- entries containing the internal i2b2 identifiers, with the special source "HIVE"
INSERT INTO i2b2demodata.patient_mapping VALUES ('40', 'HIVE', 40, 'A', 'HIVE', NULL, 'NOW()', 'NOW()', 'NOW()', 'edu.harvard.i2b2.crc', 1);
INSERT INTO i2b2demodata.patient_mapping VALUES ('39', 'HIVE', 39, 'A', 'HIVE', NULL, 'NOW()', 'NOW()', 'NOW()', 'edu.harvard.i2b2.crc', 1);


------------------------------------------------------------------------------------------------------------------------
-----TABLE patient_dimension--------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- dimension table containing the patient data, identified by their internal i2b2 identifiers (patient_num)
-- this includes the dummy encrypted flag in the "enc_dummy_flag" column
--- example with 2 patients: same as in the patient_mapping table, 1 patient = 1 entry

INSERT INTO i2b2demodata.patient_dimension VALUES (40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, "FzXxSbBn86gMmF7WT6a4kHDcHrOg3SEkaojcPm7U3qsQp0bhzaLZLYenL/+yNS5j39TFcLU1uSUE5I8tD3Qryw==");
INSERT INTO i2b2demodata.patient_dimension VALUES (39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, "66xaTIbPcE8V/4u9cE7UWFjgBPpu7yBMSfLSsNrDeTssfy57z5DfTAI+ynrVMzosOapo2SqQxRrrKFSWIljEbw==");


------------------------------------------------------------------------------------------------------------------------
-----TABLE encounter_mapping--------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- mappings of the encounter (= visit) identifiers: similar use as "patient_mapping", note that it additionally contains
-- the patient identifier
--- example with 2 visits/encounters: "MEL-Ma-Mel-103b" and "MEL-Ma-Mel-102"
--- note: in the example of this specific dataset the visits are interpreted as samples, and there are as many samples
--- as patients, but this is not necessarily always the case

-- entries containing the identifiers from the external source (here the source is defined as "chuv")
INSERT INTO i2b2demodata.encounter_mapping VALUES ('MEL-Ma-Mel-103b', 'chuv', 'Demo', 36, 'MEL-Ma-Mel-103b', 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1);
INSERT INTO i2b2demodata.encounter_mapping VALUES ('MEL-Ma-Mel-102', 'chuv', 'Demo', 30, 'MEL-Ma-Mel-102', 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1);

-- entries containing the internal i2b2 identifiers, with the special source "HIVE"
INSERT INTO i2b2demodata.encounter_mapping VALUES ('36', 'HIVE', 'HIVE', 36, 'MEL-Ma-Mel-103b', 'chuv', 'A', NULL, 'NOW()', 'NOW()', 'NOW()', 'edu.harvard.i2b2.crc', 1);
INSERT INTO i2b2demodata.encounter_mapping VALUES ('30', 'HIVE', 'HIVE', 30, 'MEL-Ma-Mel-102', 'chuv', 'A', NULL, 'NOW()', 'NOW()', 'NOW()', 'edu.harvard.i2b2.crc', 1);


------------------------------------------------------------------------------------------------------------------------
-----TABLE visit_dimension----------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- similar to patient_dimension, contains encounters (sample) identifiers (encounter_num)
INSERT INTO i2b2demodata.visit_dimension VALUES (36, 40, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NOW()', 'chuv', 1);
INSERT INTO i2b2demodata.visit_dimension VALUES (30, 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'NOW()', 'chuv', 1);



------------------------------------------------------------------------------------------------------------------------
-----TABLE provider_dimension-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- contains the different providers defined in the system
--- here just chuv is defined and used everywhere

INSERT INTO i2b2demodata.provider_dimension VALUES ('chuv', '\\medco\\institutions\\chuv\\', 'chuv', NULL, NULL, NULL, 'NOW()', NULL, 1);


------------------------------------------------------------------------------------------------------------------------
-----TABLE observation_fact---------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
-- the observation facts, that link a patient, a visit, a concept, a provider, and a date

-- clear / normal i2b2 observation facts, for clinical non-sensitive data, nb entries = nb rows in clinical dataset * nb non-sensitive columns
-- concept codes are the ones defined in i2b2metadata.clinical_non_sensitive
INSERT INTO i2b2demodata.observation_fact VALUES (39, 30, 'CLEAR:1', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (39, 30, 'CLEAR:2', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (40, 36, 'CLEAR:1', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (40, 36, 'CLEAR:3', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);


-- encrypted observation facts, contains both clinical sensitive and genomic tagged values (1 tagged value = 32B = 44 base64 characters)
-- here as an example we are adding 3 sensitive attributes
INSERT INTO i2b2demodata.observation_fact VALUES (39, 30, 'TAG:EkaojcPm7U3qsQp0bhzaLZLYenL/+yNS5j39TFcLU1u=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (39, 30, 'TAG:BMSfLSsNrDeTssfy57z5DfT8V/4u9cE7UWFjgBPpu7y=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (39, 30, 'TAG:eTssfFjgBPBMSfLSsNrDpu7yy57z5DfT8V/4u9cE7UW=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (40, 36, 'TAG:U3qsQp0bhzaEkaojcP39TFcLU1um7LZLYenL/+yNS5j=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (40, 36, 'TAG:8V/4u9cE7UWFjgBPpu7yBMSfLSsNrDeTssfy57z5DfT=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
INSERT INTO i2b2demodata.observation_fact VALUES (40, 36, 'TAG:WFjgBPpu7yBMSfLSsNrDeTs8V/sfy57z5DfT4u9cE7U=', 'chuv', 'NOW()', '@', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'chuv', NULL, NULL, NULL, NULL, 'NOW()', NULL, 1, 1);
