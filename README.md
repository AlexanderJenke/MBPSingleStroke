# MBPSingleStroke

This menubar app tracks your keystokes and simulates an backspace press when an
character is typed twice within 0.1 seconds.

The goal is to address an annoying problem I am having with my MacBook Pro
2018, where multiple keystrokes are detected when the key is only pressed once.

These double keystrokes within 0.1s almost always their origin in
an erroneous detection of the second key press.

Every time a backspace is simulated a sound is played.

## Installation

You need to add the application as trusted application in order to enable the
detection of keystrokes.

You can do this with these steps:
1. Go to __System Preferences__ > __Security & Privacy__
2. Open the __Privacy__ tab, and look for __Accessibility__ in the left list
3. Add the __MBPSingleStroke.app__ to the right list
