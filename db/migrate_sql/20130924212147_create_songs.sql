CREATE TABLE "songs" ("id" serial primary key, "artist" character varying(255), "title" character varying(255), "movie_id" integer, "created_at" timestamp, "updated_at" timestamp) ;
CREATE  INDEX  "index_songs_on_movie_id" ON "songs"  ("movie_id");
INSERT INTO schema_migrations (version) VALUES (20130924212147);
