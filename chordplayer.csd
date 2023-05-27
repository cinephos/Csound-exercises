<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>
; The chord player by Michalis Kaloumenos
; 
; The chordplayer is based on the idea that all chords can be included in a single table,
; and can be played by a single loop. 
; triads come first, all three inversions in the closed position followed by all three
; inversions in an open position. 4-note chords follow, closed position inversions and
; a selected open position for each inversion. There are 2 empty slots for variations.
; A single 5 note chord is included. The table can be extended, of course.

; The root of the scale is defined as a global variable, therefore all notes and chords
; must be referred to as semitones (midi key increments) of the root. For negative values
; in the score, the notation [7-12] is selected instead of -5, because it is easier to
; remember that a perfect fifth is played an octave lower.

; Initialize the global variables. 
ksmps = 32
nchnls = 2
0dbfs = 1

giroot      =         55           ; root is G
gichords[]  fillarray 0, 4, 7, 4, 7, 12, 7, 12, 16,         ; 0  major closed
                      0, 7, 16, 4, 12, 19, 7, 16, 24, 0, 0, ;    major open
                      0, 3, 7, 3, 7, 12, 7, 12, 15,         ; 20 minor closed
                      0, 7, 15, 3, 12, 19, 7, 15, 24, 0, 0, ;    minor open
                      0, 4, 8, 4, 8, 12, 8, 12, 16,         ; 40 augmented 5th closed
                      0, 8, 16, 4, 12, 20, 8, 16, 24, 0, 0, ;    augmented 5th open
                      0, 3, 6, 3, 6, 12, 6, 12, 15,         ; 60 diminished 5th closed
                      0, 6, 15, 3, 12, 18, 6, 15, 24, 0, 0, ;    diminished 5th open
                      0, 5, 7, 5, 7, 12, 7, 12, 17,         ; 80 sus 4 closed
                      0, 7, 17, 5, 12, 19, 7, 19, 24, 0, 0, ;    sus 4 open
                      0, 4, 7, 11, 4, 7, 11, 12, 7, 11, 12, 16, 11, 12, 16, 19,     ; 100 major with maj7 closed
                      0, 7, 11, 16, 4, 11, 12, 19, 7, 11, 16, 24, 11, 16, 19, 24,   ;     major with maj7 open
                      0, 0, 0, 0, 0, 0, 0, 0, 
                      0, 4, 7, 10, 4, 7, 10, 12, 7, 10, 12, 16, 10, 12, 16, 19,     ; 140 major 7 closed
                      0, 7, 10, 16, 4, 10, 12, 19, 7, 10, 16, 24, 10, 16, 19, 24,   ;     major 7 open
                      0, 0, 0, 0, 0, 0, 0, 0,                       
                      0, 4, 7, 9, 4, 7, 9, 12, 7, 9, 12, 16, 9, 12, 16, 19,         ; 180 major 6 closed
                      0, 7, 9, 16, 4, 9, 12, 19, 7, 9, 16, 24, 9, 16, 19, 24,       ;     major 6 open
                      0, 0, 0, 0, 0, 0, 0, 0,
                      0, 3, 7, 10, 3, 7, 10, 12, 7, 10, 12, 15, 10, 12, 15, 19,     ; 220 minor 7 closed
                      0, 7, 10, 15, 3, 10, 12, 19, 7, 10, 15, 24, 10, 15, 19, 24,   ;     minor 7 open
                      0, 0, 0, 0, 0, 0, 0, 0,
                      0, 3, 7, 9, 3, 7, 9, 12, 7, 9, 12, 15, 9, 12, 15, 19,         ; 260 minor 6 closed
                      0, 7, 9, 15, 3, 9, 12, 19, 7, 9, 15, 24, 9, 15, 19, 24,       ;     minor 6 open
                      0, 0, 0, 0, 0, 0, 0, 0,                      
                      0, 3, 6, 10, 3, 6, 10, 12, 6, 10, 12, 15, 10, 12, 15, 18,     ; 300 minor 7 (b5) half diminished closed
                      0, 6, 10, 15, 3, 10, 12, 18, 6, 10, 15, 24, 10, 15, 18, 24,   ;     minor 7 (b5) half diminished open
                      0, 0, 0, 0, 0, 0, 0, 0,
                      0, 3, 6, 9, 3, 6, 9, 12, 6, 9, 12, 15, 9, 12, 15, 18,         ; 340 diminished closed
                      0, 6, 9, 15, 3, 9, 12, 18, 6, 9, 15, 24, 9, 15, 18, 24,       ;     diminished open
                      0, 0, 0, 0, 0, 0, 0, 0,
                      0, 5, 7, 10, 5, 7, 10, 12, 7, 10, 12, 17, 10, 12, 17, 19,     ; 380 7th sus 4 closed
                      0, 7, 10, 17, 5, 10, 12, 19, 7, 10, 17, 24, 10, 17, 19, 24,   ;     7th sus 4 open
                      0, 0, 0, 0, 0, 0, 0, 0,
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   ; 420 empty slots
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   ; 440 empty slots
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   ; 460 empty slots
                      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,   ; 480 empty slots 
                      0, 4, 7, 10, 13                                               ; 500 major 7th b9

instr 1
 iindex  = 0
 idur    = p3
 iamp    = p4
 idegree = p5
 ichord  = p6
 iinv    = p7
 ipos    = p8

; the if block decides how many voices to be played for the selected chord.  
 if ichord < 100 then
  ivoices   =   3
  ioc       =   9
 elseif ichord >= 100 && ichord < 500 then
  ivoices   =   4
  ioc       =   16
 else
  ivoices   =   5
  ioc       =   25 
 endif  

; the while block selects the notes of each chord and plays the notes 
 while iindex < ivoices do
  schedule "b3", 0, idur, mtof(giroot + idegree + gichords[ichord + (ioc * ipos) + (ivoices * iinv) + iindex]), iamp

; if you extend the gichords[] table, you may want to uncomment the following lines. The first
; prints the index of the table, and the second prints the calculated midi key to be played.  
; print ichord + (ioc * ipos) + (ivoices * iinv) + iindex
; print giroot + idegree + gichords[ichord + (ioc * ipos) + (ivoices * iinv) + iindex]

  iindex    +=  1 
 od

endin
 
instr b3
 ifreq      =       p4
 iamp       =       p5
 kvdpth     line    0, p3, .1
 asig       fmb3    iamp, ifreq, 5, 5, kvdpth, 6
 aout       linen   asig, .1, p3, .1
            outs    aout, aout
endin

; instr 2 plays the melody
instr 2
 iamp       =       p4
 idegree    =       p5
 iFreq      mtof    giroot + idegree
 aPluck     pluck   .2, iFreq, iFreq, 0, 1
 aOut       linen   aPluck, 0, p3, p3/2
            outs    aOut, aOut
endin       

</CsInstruments>
<CsScore>
t 0 20  ; 20 whole notes per minute

; the following example playes a few bars from "Autumn leaves" by Joseph Kosma

; instr start   dur     amp degree      chord   inversion   position 0=closed, 1=open
i 1     1       .5      .03 2           220     0           0       ; iv 7 (4th degree of the minor scale)
i 1     +       .       .   [7-12]      140     2           0       ; b VII 7
i 1     +       .       .   0           100     0           0       ; b III maj7
i 1     +       .       .   [5-12]      100     2           0       ; b VI maj7
i 1     +       .       .   [11-12]     300     0           0       ; ii 7 b5
i 1     +       .       .   [4-12]      140     2           0       ; V 7
i 1     +       .625    .   [9-12]      20      1           0       ; i

; time .125 represents an eigth note, .25 a quarter note, .5 a half note etc 
i 2 .625    .125    .3  [9-12]
i 2 +       .       .   [11-12]
i 2 +       .       .   0 
i 2 +       .625    .   5           ; bar 1
i 2 +       .125    .   [7-12]
i 2 +       .       .   [9-12]
i 2 +       .       .   [11-12]
i 2 +       .25     .   4           ; bar 2
i 2 +       .375    .   4
i 2 +       .125    .   [5-12]
i 2 +       .       .   [7-12]
i 2 +       .       .   [9-12]
i 2 +       .625    .   2           ; bar 3
i 2 +       .125    .   [4-12]
i 2 +       .       .   [6-12]
i 2 +       .       .   [8-12]
i 2 +       .625    .   0           ; bar 4

e
</CsScore>
</CsoundSynthesizer>
