
-- Create user (if not exists)
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles WHERE rolname = 'java_user'
   ) THEN
      CREATE USER java_user WITH PASSWORD 'QAZxsw2';
   END IF;
END
$do$;
--CREATE DATABASE java_db;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE java_db TO java_user;

\connect java_db

GRANT CREATE ON SCHEMA public TO java_user;
GRANT USAGE ON SCHEMA public TO java_user;

-- Allow connections from all addresses
ALTER SYSTEM SET listen_addresses TO '*';
