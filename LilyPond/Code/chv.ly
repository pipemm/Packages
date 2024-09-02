
\version "2.24.4"

\header {
  title = "Waltz (ワルツ)"
  composer = "Composer"
}

<<
  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano"
    \new Staff {\tempo 4 = 100 \clef treble \key g \major \time 6/8
      b' b'8 b' a' g'
    }
  >>

  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano 2"
    \new Staff {\clef treble \key g \major
      R2. | R2.
    }
    \new Staff \relative { \clef bass \key g \major
      c4 c' 
    }
  >>
>>
