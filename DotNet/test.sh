
url_page='https://dotnet.microsoft.com/download/dotnet'

curl --silent --show-error --fail "${url_page}" |
  sed --silent 's!^.* href="[^"]*/download/dotnet/\([0-9.]*\)".*$\|^.* class="badge badge-\([^"]*\)".*$!\1\2!p'
