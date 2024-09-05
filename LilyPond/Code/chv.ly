
\version "2.24.4"

\header {
  title = "Waltz (ワルツ)"
  composer = "Composer"
}

<<
  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano"
    \new Staff {\tempo 4 = 100 \clef treble \key g \major \time 6/8
      b' b'8 b' a' g' | 
      c''4.~ c'' |
      fis'4 fis'8 fis' e' d' |
      b'4.~ b' |
    }
  >>

  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano 2"
    \new Staff {\clef treble \key g \major
      R2. | R2. | R2. | R2. |
    }
    \new ChordNames {
      \chordmode {
        e:m | c | d | g 
      }
    }
    \new Staff { \clef bass \key g \major
      e,8 <b, e g> <b, e g> r <b, e g> <b, e g> | 
      e,8 <c e g> <c e g> e, <c e g>4           |
      d,8 <d fis a> <d fis a> r  <d fis a> <d fis a> |
      g,8 <d g b> <d g b> g, <d g b>4 |
    }
  >>
  \new Staff \with {
    instrumentName = "Violin"
    shortInstrumentName = "Vln."
  }{ \clef treble \key g \major \time 6/8
    e'4.~ e'4 fis'8   |
    g'4.~ g'8 b' a'~  |
    a'4.~ a'          |
    b'4.~ b'8 d'' c'' |
  }
  \new Staff \with {
    instrumentName = "El. Bass"
    shortInstrumentName = "El. B."
  }{ \clef bass \key g \major \time 6/8
    e,4 e,8~ e,4 d,8     |
    c,4 e,8~ e,4 c,8     |
    d,4 fis,8~ fis,4 a,8 |
    g,4.~ g,8 g, fis,
  }
  \new DrumStaff \with {
    instrumentName = "Acoustic"
  }{ 
    \drummode {
      hh8 hh hh hh hh hh
    }
  }
>>
