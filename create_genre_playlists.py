#!/usr/bin/env python

# This would actually be useful if the genre field was kept up to date. 
# So far every album I've checked is empty and only about 1/4 of my artists
# So no guarentees this will make useful playlists at this time
from SpotifyPM import SpotifyPM

spm = SpotifyPM()
# Turn this into argparse argument
username = spm.get_username()
# Turn scope into argparse argument
sp = spm.auth(username, 'playlist-read-private')

if sp != None:
    track_list = spm.get_all_tracks(sp)
    spm.create_genre_playlists(track_list, sp)
else:
    print "Can't get token for", username

