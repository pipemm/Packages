
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

stat /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
stat /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

## The program detect the file timestamp of Scheme source code (.scm) and the compiled file (.go). If the source code has a newer timestamp than the complied file, a warning message will be raised.
## It sounds like related to the setting GUILE_AUTO_COMPILE=1.


(
  ls Package/lilypond-*/lib/*/*/ccache/*/*.go &
  ls Package/lilypond-*/lib/*/*/ccache/*/*/*.go
) |
  while read -r gofile
  do
    touch "${gofile}"
  done

ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/share/guile/2.2/ice-9/eval.scm
ls -l --time-style=full-iso /home/runner/work/Packages/Packages/LilyPond/Package/lilypond-*/lib/guile/2.2/ccache/ice-9/eval.go

