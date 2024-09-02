
\version "2.24.4"

\header {
  title = "Waltz (ワルツ)"
  composer = "Composer"
}

<<
  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano"
    \new Staff {\tempo 4 = 100 \clef treble \key g \major \time 6/8
      b' b'8 b' a' g' | c''4. c'' |
    }
  >>

  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano 2"
    \new Staff {\clef treble \key g \major
      R2.             | R2.       |
    }
    \new Staff { \clef bass \key g \major
      e,8 <b, e g> <b, e g> r <b, e g> <b, e g> | e, <b, e g> <b, e g> e, <b, e g>4
    }
  >>
>>

