CREATE ROLE irct LOGIN PASSWORD 'irct';
CREATE ROLE i2b2 LOGIN PASSWORD 'i2b2';
CREATE ROLE keycloak LOGIN PASSWORD 'keycloak';
CREATE ROLE picsure LOGIN PASSWORD 'picsure';
ALTER USER irct CREATEDB;
ALTER USER i2b2 CREATEDB;
ALTER USER keycloak CREATEDB;
ALTER USER picsure CREATEDB;
