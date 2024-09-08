
\version "2.24.4"

\header {
  title     = "Waltz"
  subtitle  = \markup {
    \override #'(font-size . -5)
    \italic \with-color "gray"
    {\concat { "31"\super{"st"} } "Auguest 2024"}
  }
  composer  = "Chevin"
  copyright = "© Chevin 2024"
  tagline   = "© Chevin 2024"
}

\score {
  \layout {
    indent       = 1.5\cm
    short-indent = 1.5\cm
  }
<<
  \new PianoStaff \with {
    instrumentName      = "Piano"
    shortInstrumentName = "Pno."
  }{\tempo 4 = 100 \clef treble \key g \major \time 6/8
    b'4 b'8 b' a' g'            | 
    c''4.~c''                   |
    fis'4 fis'8 fis' e' d'      |
    b'4.~b'                     |

    b'4 b'8 b' c'' d''          |
    e''4. e'4 e'16 g'           |
    fis'4 e'8 d'4 a'8           |
    g'4.~g'4.                   |
    
    fis'4\f fis'8 fis' g' a'    | % forte
    fis'4 fis'8 fis' g' a'      |
    c''4 b'8 a'~a'16 fis' g' a' |
    b'4.\>~b'                   | % decrescendo, 

    c''4 b'8 a'8. fis'16 g' a'  |
    b'4 a'16 g' e'4.            |
    fis'4 a'8 c''4 dis'8        |
    e'4.~e'4.     \!            |
  }

  \new PianoStaff \with {
    instrumentName      = "Piano 2"
    shortInstrumentName = "Pno. 2"
  }<<
    \new Staff {\clef treble \key g \major
      \repeat unfold 4 \repeat unfold 4 {R2. | }
      \bar "|."
    }
    \new ChordNames {
      \chordmode {
        e:m | c   | d   | g   |

        e:m | c   | d   | g   |

        d   | b:m | a:m | e:m |

        a:m | g   | b:7 | e:m |
      }
    }
    \new Staff { \clef bass \key g \major
      e,8 <b, e g> <b, e g> r <b, e g> <b, e g>        | 
      e,8 <c e g> <c e g> e, <c e g>4                  |
      d,8 <d fis a> <d fis a> r  <d fis a> <d fis a>   |
      g,8 <d g b> <d g b> g, <d g b>4                  |

      e,8 <b, e g> <b, e g> r <b, e g> <b, e g>        |
      e,8 <c e g> <c e g> e, <c e g>4                  |
      d,8 <d fis a> <d fis a> r  <d fis a> <d fis a>   |
      g,8 <d g b> <d g b> <g, b, d>4.                  |

      d,8 <d fis a> <d fis a> fis, <d fis a> <d fis a> |
      b,,8 <d fis b> <d fis b> d, <d fis b> <d fis b>  |
      a,,8 <c e a> <c e a> c, <c e a> <c e a>          |
      g,,8 <b, e g> <b, e g> b,, <b, e g> <b, e g>     |

      a,,8 <c e a> <c e a> c, <c e a> <c e a>          |
      g,,8 <b, d g> <b, d g> b,, <b, d g> <b, d g>     |
      b,,8 <b, dis fis a> <b, dis! fis a> 
          dis, <b, dis fis a> <b, dis! fis a>          |
      e,8 <b, e g> <b, e g> <e, g, b,>4.               |

    }
    \new Lyrics \lyricmode { %% harmonic analysis : Functional Harmony (Tonic, Subdominant, Dominant)
      T2.   S   D   T 
      T2.   S   D   T 
      SD2.  MD  SDM TM
      SDM2. TM  D   TM
    }
    \new Lyrics \lyricmode { %% harmonic analysis : Roman Numeral Analysis
      VI2.   IV   V   I 
      VI2.   IV   V   I 
      ♭VII2. V-   IV- I- 
      IV-2.  ♭III \markup{V\super{7}} I-
    }
  >>
  
  \new Staff \with {
    instrumentName      = "Violin"
    shortInstrumentName = "Vln."
  }{ \clef treble \key g \major \time 6/8
    e'4.~e'4 fis'8    |
    g'4.~g'8 b' a'~   |
    a'4.~a'           |
    b'4.~b'8 d'' c''  |

    b'4.~b'4 a'8      |
    c''4.~c''4.       |
    a'4.~a'4 b'8      |
    g'4. fis'8 g' a'  |

    d'4.~d'4 c'8      |
    b4.~b8 c' d'      |
    e'4.~e'4 c''8     |
    b'4.~b'8 a' b'    |

    a'4.\> fis'4 c''8 |
    b'4. g'4 g'8      |
    fis'4. a'4 b'8    |
    e'4.~e' \!        |
  }

  \new Staff \with {
    instrumentName      = "El. Bass"
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

    d4 a8 c'4 b8         |
    b4.~b4 b8            |
    a4 c'8~c'8 c d       |
    d4.~d                |

    a,4. e,4 fis,8       |
    g,4 d8~d4 c8         |
    b,4 dis8~dis!4 fis8  |
    e4.~e                |
  }

  \new DrumStaff \with {
    instrumentName      = "Drum Set"
    shortInstrumentName = "Dr. St."
    drumStyleTable      = #weinberg-drums-style
  }{ \time 6/8
    \drummode {
      <<
        \new DrumVoice { \voiceOne
          \repeat unfold 5 {
            hh8 hh hh <hh sn> hh hh        |
          }
          \repeat unfold 2 {
            hh8 hh hh hh hh hh             |
          }
          hh8 hh hh  <hh sn> hh16 hh hh hh |

          <hh cymr>8 hh hh <hh sn> hh hh   |
          \repeat unfold 6 {
            hh8 hh hh <hh sn> hh hh        |
          }
          hh8 hh hh hh4.                   |
        }
        \new DrumVoice { \voiceTwo
          \repeat unfold 7 {
            bd8 r16 bd16 bd8 r4 bd8        |
          }
          bd4. r4 r16 bd16

          \repeat unfold 4 {
            bd4 r16 bd16 r4 bd8            |
          }

          \repeat unfold 3 {
            bd4. r4 bd8                    |
          }
          bd4. r4.                         |
        }
        \fine
      >>
    }
  }
>>
}
