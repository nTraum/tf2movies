ALTER TABLE "users" ADD COLUMN "last_online" timestamp;
INSERT INTO schema_migrations (version) VALUES (20130922141714);
