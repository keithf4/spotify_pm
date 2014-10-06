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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: album; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE album (
    id text NOT NULL,
    name text NOT NULL,
    album_type text NOT NULL,
    release_date date,
    genres text[]
);


ALTER TABLE public.album OWNER TO keith;

--
-- Name: album_track; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE album_track (
    album_id text NOT NULL,
    track_id text NOT NULL
);


ALTER TABLE public.album_track OWNER TO keith;

--
-- Name: artist; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE artist (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.artist OWNER TO keith;

--
-- Name: playlist; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE playlist (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.playlist OWNER TO keith;

--
-- Name: playlist_track; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE playlist_track (
    playlist_id text NOT NULL,
    track_id text NOT NULL,
    added_at timestamp with time zone NOT NULL,
    added_by text NOT NULL
);


ALTER TABLE public.playlist_track OWNER TO keith;

--
-- Name: track; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE track (
    id text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.track OWNER TO keith;

--
-- Name: track_artist; Type: TABLE; Schema: public; Owner: keith; Tablespace: 
--

CREATE TABLE track_artist (
    track_id text NOT NULL,
    artist_id text NOT NULL
);


ALTER TABLE public.track_artist OWNER TO keith;

--
-- Name: album_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY album
    ADD CONSTRAINT album_pkey PRIMARY KEY (id);


--
-- Name: album_track_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_pkey PRIMARY KEY (album_id, track_id);


--
-- Name: artist_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY artist
    ADD CONSTRAINT artist_pkey PRIMARY KEY (id);


--
-- Name: playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY playlist
    ADD CONSTRAINT playlist_pkey PRIMARY KEY (id);


--
-- Name: playlist_track_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_pkey PRIMARY KEY (playlist_id, track_id);


--
-- Name: track_artist_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_pkey PRIMARY KEY (track_id, artist_id);


--
-- Name: track_pkey; Type: CONSTRAINT; Schema: public; Owner: keith; Tablespace: 
--

ALTER TABLE ONLY track
    ADD CONSTRAINT track_pkey PRIMARY KEY (id);


--
-- Name: album_track_track_id_album_id_idx; Type: INDEX; Schema: public; Owner: keith; Tablespace: 
--

CREATE INDEX album_track_track_id_album_id_idx ON album_track USING btree (track_id, album_id);


--
-- Name: artist_name_idx; Type: INDEX; Schema: public; Owner: keith; Tablespace: 
--

CREATE INDEX artist_name_idx ON artist USING btree (name);


--
-- Name: playlist_track_track_id_playlist_id_idx; Type: INDEX; Schema: public; Owner: keith; Tablespace: 
--

CREATE INDEX playlist_track_track_id_playlist_id_idx ON playlist_track USING btree (track_id, playlist_id);


--
-- Name: track_artist_artist_id_track_id_idx; Type: INDEX; Schema: public; Owner: keith; Tablespace: 
--

CREATE INDEX track_artist_artist_id_track_id_idx ON track_artist USING btree (artist_id, track_id);


--
-- Name: track_name_idx; Type: INDEX; Schema: public; Owner: keith; Tablespace: 
--

CREATE INDEX track_name_idx ON track USING btree (name);


--
-- Name: album_track_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_album_id_fkey FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE;


--
-- Name: album_track_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY album_track
    ADD CONSTRAINT album_track_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE;


--
-- Name: playlist_track_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES playlist(id) ON DELETE CASCADE;


--
-- Name: playlist_track_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY playlist_track
    ADD CONSTRAINT playlist_track_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE;


--
-- Name: track_artist_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE;


--
-- Name: track_artist_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: keith
--

ALTER TABLE ONLY track_artist
    ADD CONSTRAINT track_artist_track_id_fkey FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

