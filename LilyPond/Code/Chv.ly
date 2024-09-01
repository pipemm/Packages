
\version "2.24.4"

\header {
  title = "Waltz (ワルツ)"
  composer = "Composer"
}

<<
  \new PianoStaff = "piano" <<
    \new Staff {\clef treble \key e \minor \time 6/8
      c''4 
    }
  >>

  \new PianoStaff = "piano" <<
    \new Staff \relative {\clef treble \key e \minor  
      c''4 e 
    }
    \new Staff \relative { \clef bass 
      c4 c' 
    }
  >>
>>
