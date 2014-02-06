CREATE TABLE "users" ("id" serial primary key, "nickname" character varying(255), "steam_id" character varying(255), "steam_profile_url" character varying(255), "last_logoin" timestamp, "banned" boolean, "admin" boolean, "moderator" boolean, "created_at" timestamp, "updated_at" timestamp) ;
INSERT INTO schema_migrations (version) VALUES (20130907151344);
