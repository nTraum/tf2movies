CREATE TABLE "authors" ("id" serial primary key, "nickname" character varying(255), "profile_url" character varying(255), "thumbnail_url" character varying(255), "created_at" timestamp, "updated_at" timestamp) ;
INSERT INTO schema_migrations (version) VALUES (20130924125312);
