CREATE TABLE "movies" ("id" serial primary key, "youtube_id" character varying(255), "title" character varying(255), "description" text, "views" integer, "duration" integer, "author_id" integer, "user_id" integer, "created_at" timestamp, "updated_at" timestamp) ;
INSERT INTO schema_migrations (version) VALUES (20130924125806);
