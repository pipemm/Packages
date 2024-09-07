
\version "2.24.4"


\header {
  title = "Waltz (ワルツ)"
  composer = "Composer"
}

<<
  \new PianoStaff \with {
    instrumentName = "Piano"
    shortInstrumentName = "Pno."
  }{\tempo 4 = 100 \clef treble \key g \major \time 6/8
    b'4 b'8 b' a' g'       | 
    c''4.~ c''             |
    fis'4 fis'8 fis' e' d' |
    b'4.~ b'               |

    b'4 b'8 b' c'' d''     |
    e''4. e'4 e'16 g'      |
    fis'4 e'8 d'4 a'8      |
    g'4.~ g'4.

  }

  \new PianoStaff <<
    \set PianoStaff.instrumentName = "Piano 2"
    \set PianoStaff.shortInstrumentName = "Pno. 2"
    \new Staff {\clef treble \key g \major
      \repeat unfold 2 \repeat unfold 4 {R2. | }
    }
    \new ChordNames {
      \chordmode {
        e:m | c | d | g 
      }
    }
    \new Staff { \clef bass \key g \major
      e,8 <b, e g> <b, e g> r <b, e g> <b, e g>      | 
      e,8 <c e g> <c e g> e, <c e g>4                |
      d,8 <d fis a> <d fis a> r  <d fis a> <d fis a> |
      g,8 <d g b> <d g b> g, <d g b>4                |

      e,8 <b, e g> <b, e g> r <b, e g> <b, e g>      |
      e,8 <c e g> <c e g> e, <c e g>4                |
      d,8 <d fis a> <d fis a> r  <d fis a> <d fis a> |
      g,8 <d g b> <d g b> <g, b, d>4.                |
    }
    \new Lyrics \lyricmode { %% harmonic analysis : Functional Harmony (Tonic, Subdominant, Dominant)
      T2.  S  D  T 
    }
    \new Lyrics \lyricmode { %% harmonic analysis : Roman Numeral Analysis
      VI2. IV V  I 
    }
  >>
  
  \new Staff \with {
    instrumentName = "Violin"
    shortInstrumentName = "Vln."
  }{ \clef treble \key g \major \time 6/8
    e'4.~ e'4 fis'8    |
    g'4.~ g'8 b' a'~   |
    a'4.~ a'           |
    b'4.~ b'8 d'' c''  |

    b'4.~ b'4 a'8      |
    c''4.~ c''4.       |
    a'4.~ a'4 b'8      |
    g'4. fis'8 g' a'   |
  }

  \new Staff \with {
    instrumentName = "El. Bass"
    shortInstrumentName = "El. B."
  }{ \clef bass \key g \major \time 6/8
    e,4 e,8~ e,4 d,8     |
    c,4 e,8~ e,4 c,8     |
    d,4 fis,8~ fis,4 a,8 |
    g,4.~ g,8 g, fis,    |

    e,4 e,8~ e,4 d,8     |
    c,4 e,8~ e,4 c,8     |
    d,4 fis,8~ fis,4 a,8 |
    g,4.~ g,             |
  }

  \new DrumStaff \with {
    instrumentName = "Drum Set"
    shortInstrumentName = "Dr. St."
  }{ \time 6/8
    \drummode {
      <<
        \new DrumVoice { \voiceOne
          \repeat unfold 5 {
            cymr8 cymr cymr <cymr sn> cymr cymr            |
          }
          \repeat unfold 2 {
            cymr8 cymr cymr cymr cymr cymr                 |
          }
          cymr8 cymr cymr  <cymr sn> cymr16 cymr cymr cymr |
        }
        \new DrumVoice { \voiceTwo
          \repeat unfold 7 {
            bd8 r16 bd16 bd8 r4 bd8 |
          }
          bd4. r4 r16 bd16
        }
      >>
    }
  }
>>

