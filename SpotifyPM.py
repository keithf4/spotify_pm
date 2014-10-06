#!/usr/bin/env python

# Uses environment variables for API keys. Set appropriately.
# export SPOTIPY_CLIENT_ID='your-spotify-client-id'
# export SPOTIPY_CLIENT_SECRET='your-spotify-client-secret'
# export SPOTIPY_REDIRECT_URI='your-app-redirect-url'

import spotipy
import spotipy.util as util
import sys
import time

class SpotifyPM:

    def __init__(self):
        pass

    def auth(self, username, scope):
        token = util.prompt_for_user_token(username, scope)
        sp = spotipy.Spotify(auth=token)
        return sp


    def close_conn(self, conn):
        conn.close()


    def create_conn(self):
        import psycopg2
        conn = psycopg2.connect("dbname=spotify")
        return conn


    # uses lists returned by create_track_list
    def create_genre_playlists(self, track_list, sp):
        for t in track_list:
            artist = sp.artist(t['artists'][0]['id'])
            genres = artist['genres']
            print artist['name']
            print genres
            print "Still a work in progress. Currently only prints out the artist and associated genres"
            print "No actual changes are done to your spotify playlists yet"


    # "tracks" argument is a playlist track object
    # merges the added_at and added_by values into the track object
    def create_track_list(self, tracks):
        track_list = []
        for item in tracks['items']:
            track = item['track']
            track['added_at'] = item['added_at']
            track['added_by'] = item['added_by']
            track_list.append(item['track'])
        return track_list


    def get_all_tracks(self, sp, throttle=0):
        track_list = []
        offset = 0
        results = sp.current_user_saved_tracks(20, 0)
        while results['next']:
            for item in results['items']:
                track_list.append(item['track'])
            offset += 20 
            results = sp.current_user_saved_tracks(20, offset)
            time.sleep(throttle)
        return track_list


    def get_username(self):
        if len(sys.argv) > 1:
            username = sys.argv[1]
        else:
            print "Usage: %s username" % (sys.argv[0],)
            sys.exit()
        return username


    def find_dupe_track(self, track_list, field="name"):
        seen = set()
        dupe_list = []
        for t in track_list:
            if t[field] not in seen:
                seen.add(t[field])
            else:
                dupe_list.append(t[field])
        return dupe_list


    def find_dupe_in_playlist(self, sp, playlist, username, field="name"):
        results = sp.user_playlist(username, playlist['id'], fields="tracks")
        track_list = self.create_track_list(results['tracks'])
        dupe_list = self.find_dupe_track(track_list)
        return dupe_list


    def db_populate_albums(self, sp):
        p3ass


    def db_populate_artists(self, sp):
        rows_inserted = 0
        sql_track_id = "SELECT id FROM track"
        sql_insert_artist = "INSERT INTO artist (id, name) VALUES (%s, %s)"
        sql_insert_track_artist = "INSERT INTO track_artist (track_id, artist_id) VALUES (%s, %s)"

        conn = self.create_conn() 
        conn.autocommit = True
        cur_track_id = conn.cursor()
        cur_insert_artist =  conn.cursor()

        cur_track_id.execute(sql_track_id)
        for row in cur_track_id:
            track = sp.track(row[0])
            artist = track['artists']
            for a in artist:
                try:
                    cur_insert_artist.execute(sql_insert_artist, [ a['id'], a['name'] ])
                except psycopg2.IntegrityError as e:
                    if e.pgcode == "23505":
                        pass
                    else:
                        print e.pgerror
                        sys.exit(2)
                if cur_insert_artist.rowcount > 0:
                    rows_inserted += cur_insert_artist.rowcount
                try:
                    cur_insert_artist.execute(sql_insert_track_artist, [ track['id'], a['id'] ])
                except psycopg2.IntegrityError as e:
                    if e.pgcode == "23505":
                        pass
                    else:
                        print e.pgerror
                        sys.exit(2)
                    
        cur_track_id.close()
        cur_insert_artist.close()
        self.close_conn(conn)
        return rows_inserted


    def db_populate_playlists(self, playlist, sp):
        pass

    def db_populate_tracks(self, sp):
        rows_inserted = 0
        conn = self.create_conn()
        conn.autocommit = True
        cur = conn.cursor()
        sql = "INSERT INTO public.track (id, name) VALUES (%s, %s)"
        track_list = self.get_all_tracks(sp)
        for t in track_list:
            try:
                cur.execute(sql, [ t['id'], t['name'] ])
            except psycopg2.IntegrityError as e:
                if e.pgcode == "23505":
                    pass
                    #silently ignore and keep trying to insert tracks
#                    print ("Track already exists: " + t['name'] + " (" + t['id'] + ")")
                else:
                    print e.pgerror
                    sys.exit(2)
            if cur.rowcount > 0:
                rows_inserted += cur.rowcount
        cur.close()
        self.close_conn(conn)
        return rows_inserted

# end SpotifyPM class

if __name__ == '__main__':
    spm = SpotifyPM()
    # Turn this into argparse argument
    username = spm.get_username()
    # Turn scope into argparse argument
    sp = spm.auth(username, 'playlist-read-private')
    
    if sp != None:

# Populate track table in database
        rows_inserted = spm.db_populate_tracks(sp)
        print "rows inserted: " + str(rows_inserted)

# Populate artists based on tracks
        rows_inserted = spm.db_populate_artists(sp)
        print "rows inserted: " + str(rows_inserted)

#        track_list = spm.get_all_tracks(sp)

# Check all playlists for dupes
#        playlists = sp.user_playlists(username)
#        for playlist in playlists['items']:
#            if playlist['owner']['id'] == username:
#                print playlist['name']
  #              dupe_list = spm.find_dupe_in_playlist(sp, playlist, username)
#                print "dupe_list: " + str(dupe_list)

    else:
        print "Can't get token for", username
