
\version "2.24.4"

\score {
  \layout {
    \context {
      \Score
      \override SpacingSpanner
        #'common-shortest-duration = #(ly:make-moment 1 8)
    }
  }
  \new Staff \with {
    instrumentName      = "Violin"
    shortInstrumentName = "Vln."
  }{ \clef treble \key g \major \time 6/8
    g'4.~g'8 b' a'~   |
    a'4.~a'           |
    b'4.~b'8 d'' c''  |
  }
}

\score {
  \layout {
    \context {
      \Score
      \override SpacingSpanner
        #'common-shortest-duration = #(ly:make-moment 1 8)
    }
  }
  \new Staff \with {
    instrumentName      = "Violin"
    shortInstrumentName = "Vln."
  }{ \clef treble \key g \major \time 6/8
      g'2 b'8 a'~  |
      a'4.~a'      |
      b'2 d''8 c'' |
  }
}

\score {
  \layout {
    \context {
      \Score
      \override SpacingSpanner
        #'common-shortest-duration = #(ly:make-moment 1 8)
    }
  }
  \new Staff \with {
    instrumentName      = "El. Bass"
    shortInstrumentName = "El. B."
  }{ \clef bass \key g \major \time 6/8 |
    c,4 e,8~ e,4 c,8     |
    d,4 fis,8~ fis,4 a,8 |
    g,4.~ g,8 g, fis,    |
  }
}

\score {
  \layout {
    \context {
      \Score
      \override SpacingSpanner
        #'common-shortest-duration = #(ly:make-moment 1 8)
    }
  }
  \new Staff \with {
    instrumentName      = "El. Bass"
    shortInstrumentName = "El. B."
  }{ \clef bass \key g \major \time 6/8
      c,4 e,~e,8 c,     |
      d,4 fis,~fis,8 a, |
      g,2 g,8 fis,      |
  }
}
