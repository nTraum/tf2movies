ALTER TABLE "authors" ADD COLUMN "youtube_id" character varying(255);
INSERT INTO schema_migrations (version) VALUES (20130928121859);
