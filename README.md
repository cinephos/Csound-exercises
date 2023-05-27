# Csound-exercises
Csound exercises inspired by the Floss manual and Victor Lazzarini's "Csound: A Sound and Music Computing System"

The **chordplayer** is inspired from the Floss manual basics chapter "01 B. PITCH AND FREQUENCY"

The chordplayer is based on the idea that all chords can be included in a single table and can be played by a single loop.

Triads come first, all three inversions in the closed position followed by all three nversions in an open position. 
4-note chords follow, closed position inversions and a selected open position for each inversion. 
There are 2 empty slots for variations. A single 5 note chord is included. The table can be extended, of course.

The root of the scale is defined as a global variable, therefore all notes and chords must be referred to as semitones (midi key increments) of the root.
