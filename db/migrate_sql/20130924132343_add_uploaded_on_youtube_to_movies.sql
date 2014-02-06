ALTER TABLE "movies" ADD COLUMN "uploaded_on_youtube" timestamp;
INSERT INTO schema_migrations (version) VALUES (20130924132343);
