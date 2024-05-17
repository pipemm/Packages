

curl --compressed 'https://www.python.org/downloads/windows/' |
  sed --silent 's!.* href="\([^"]*\)">\([^<]*\)<.*!\1!p' |
  sed --silent 's!^http[s]\?://\(.*/python-[0-9]\+[.][0-9]\+[.][0-9]\+-embed-[a-z0-9]\+[.]zip\)!https://\1!p'

