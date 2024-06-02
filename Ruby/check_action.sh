


folder_action='.github/workflows/'

ls "${folder_action%/}"/*.yaml |
  while read -r yfile
  do
    echo
    echo '--------------------'
    echo "processing ${yfile}"
    cat "${yfile}"
    cat "${yfile}" |
      ruby -r yaml -r json -e 'puts JSON.pretty_generate(YAML.load($stdin.read))'
  done

