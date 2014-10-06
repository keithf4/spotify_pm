#!/usr/bin/env python
from SpotifyPM import SpotifyPM

spm = SpotifyPM()
# Turn this into argparse argument
username = spm.get_username()
# Turn scope into argparse argument
sp = spm.auth(username, 'playlist-read-private')

if sp != None:
# Populate track table in database
        rows_inserted = spm.db_populate_artists(sp)
        print "New Artists Added: " + str(rows_inserted)
else:
    print "Can't get token for", username

