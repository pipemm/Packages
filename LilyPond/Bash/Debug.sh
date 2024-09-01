
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

stat /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
stat /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

(
  ls Package/lilypond-*/lib/*/*/ccache/*/*.go &
  ls Package/lilypond-*/lib/*/*/ccache/*/*/*.go
) |
  while read -r gofile
  do
    echo touch "${gofile}"
    touch "${gofile}"
  done

ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

