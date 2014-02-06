ALTER TABLE "movies" ADD COLUMN "status" character varying(255);
INSERT INTO schema_migrations (version) VALUES (20130928120459);
