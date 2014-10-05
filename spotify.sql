--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: album; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE album (
    id text NOT NULL,
    name text NOT NULL,
    album_type text NOT NULL,
    release_date date,
    genres text[]
);


--
-- Name: album_track; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE album_track (
    album_id text NOT NULL,
    track_id text NOT NULL
);


--
-- Name: artist; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE artist (
    id text NOT NULL,
    name text NOT NULL
);


--
-- Name: playlist; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE playlist (
    id text NOT NULL,
    name text NOT NULL
);


--
-- Name: playlist_track; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE playlist_track (
    playlist_id text NOT NULL,
    track_id text NOT NULL
);


--
-- Name: track; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE track (
    id text NOT NULL,
    name text NOT NULL,
    available boolean DEFAULT true NOT NULL
);


--
-- Name: track_artist; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE track_artist (
    track_id text NOT NULL,
    artist_id text NOT NULL
);


--
-- Name: album_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY album
    ADD CONSTRAINT album_pkey PRIMARY KEY (id);


--
-- Name: album_track_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_pkey PRIMARY KEY (album_id, track_id);


--
-- Name: artist_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (id);


--
-- Name: playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: playlist_track_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_pkey PRIMARY KEY (playlist_id, track_id);


--
-- Name: track_artist_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_pkey PRIMARY KEY (track_id, artist_id);


--
-- Name: track_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY track
    ADD CONSTRAINT track_pkey PRIMARY KEY (id);


--
-- Name: album_track_track_id_album_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX album_track_track_id_album_id_idx ON album_track USING btree (track_id, album_id);


--
-- Name: artist_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX artist_name_idx ON artist USING btree (name);


--
-- Name: playlist_track_track_id_playlist_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX playlist_track_track_id_playlist_id_idx ON playlist_track USING btree (track_id, playlist_id);


--
-- Name: track_artist_artist_id_track_id_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX track_artist_artist_id_track_id_idx ON track_artist USING btree (artist_id, track_id);


--
-- Name: track_name_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX track_name_idx ON track USING btree (name);


--
-- Name: album_track_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_album_id_fkey FOREIGN KEY (album_id) REFERENCES album(id);


--
-- Name: album_track_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id);


--
-- Name: playlist_track_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES playlist(id);


--
-- Name: playlist_track_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id);


--
-- Name: track_artist_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artist(id);


--
-- Name: track_artist_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id);


--
-- PostgreSQL database dump complete
--

