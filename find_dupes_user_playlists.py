#!/usr/bin/env python
from SpotifyPM import SpotifyPM

spm = SpotifyPM()
# Turn this into argparse argument
username = spm.get_username()
# Turn scope into argparse argument
sp = spm.auth(username, 'playlist-read-private')

if sp != None:
    playlists = sp.user_playlists(username)
    for playlist in playlists['items']:
        if playlist['owner']['id'] == username:
            print(playlist['name'])
            dupe_list = spm.find_dupe_in_playlist(sp, playlist, username)
            if len(dupe_list) > 0:
                for name in dupe_list:
                    print("\t" + name)
            else:
                print("\t<<No dupes>>")
else:
    print "Can't get token for", username

