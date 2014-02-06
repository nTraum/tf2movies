CREATE TABLE "downloads" ("id" serial primary key, "url" character varying(255), "movie_id" integer, "created_at" timestamp, "updated_at" timestamp) ;
CREATE  INDEX  "index_downloads_on_movie_id" ON "downloads"  ("movie_id");
INSERT INTO schema_migrations (version) VALUES (20130924212227);
