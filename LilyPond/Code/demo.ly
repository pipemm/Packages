\score {
  \layout {
    indent       = 1.5\cm
    short-indent = 1.5\cm
  }
  <<
    \new Staff \with {
      instrumentName      = "Violin"
      shortInstrumentName = "Vln."
    }{ \clef treble \key g \major \time 6/8
    %  e'4.~e'4 fis'8    |
      g'4.~g'8 b' a'~   |
      a'4.~a'           |
      b'4.~b'8 d'' c''  |
    }

    \new Staff \with {
      instrumentName      = "El. Bass"
      shortInstrumentName = "El. B."
    }{ \clef bass \key g \major \time 6/8
    %  e,4 e,8~ e,4 d,8     |
      c,4 e,8~ e,4 c,8     |
      d,4 fis,8~ fis,4 a,8 |
      g,4.~ g,8 g, fis,    |
    }
  >>
}

\score {
  \layout {
    indent       = 1.5\cm
    short-indent = 1.5\cm
  }
  <<
    \new Staff \with {
      instrumentName      = "Violin"
      shortInstrumentName = "Vln."
    }{ \clef treble \key g \major \time 6/8
      g'2 b'8 a'~  |
      a'4.~a'      |
      b'2 d''8 c'' |
    }

    \new Staff \with {
      instrumentName      = "El. Bass"
      shortInstrumentName = "El. B."
    }{ \clef bass \key g \major \time 6/8
      c,4 e,8~ e,4 c,8     |
      d,4 fis,8~ fis,4 a,8 |
      g,2 g,8 fis,    |
    }
  >>
}
