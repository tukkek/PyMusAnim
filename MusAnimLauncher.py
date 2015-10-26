# -*- coding: utf-8 -*-
from MusAnimRenderer import MusAnimRenderer
from MusAnimLexer import MidiLexer
import sys,os.path

PITCH_GRACE=5
TRACK_WIDTH=24

def main():
    tracks = [
    	{ 'name': "track0",
	'color': (0.000, 0.996, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 0
	},
	{ 'name': "track1",
	'color': (0.996, 0.000, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 1
	},
	{ 'name': "track2",
	'color': (0.004, 0.996, 0.992),
	'width': TRACK_WIDTH,
	'z-index': 2
	},
	{ 'name': "track3",
	'color': (0.996, 0.855, 0.398),
	'width': TRACK_WIDTH,
	'z-index': 3
	},
	{ 'name': "track4",
	'color': (0.563, 0.980, 0.570),
	'width': TRACK_WIDTH,
	'z-index': 4
	},
	{ 'name': "track5",
	'color': (0.000, 0.461, 0.996),
	'width': TRACK_WIDTH,
	'z-index': 5
	},
	{ 'name': "track6",
	'color': (0.832, 0.996, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 6
	},
	{ 'name': "track7",
	'color': (0.996, 0.574, 0.492),
	'width': TRACK_WIDTH,
	'z-index': 7
	},
	{ 'name': "track8",
	'color': (0.992, 0.535, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 8
	},
	{ 'name': "track9",
	'color': (0.520, 0.660, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 9
	},
	{ 'name': "track10",
	'color': (0.000, 0.680, 0.492),
	'width': TRACK_WIDTH,
	'z-index': 10
	},
	{ 'name': "track11",
	'color': (0.738, 0.773, 0.996),
	'width': TRACK_WIDTH,
	'z-index': 11
	},
	{ 'name': "track12",
	'color': (0.738, 0.824, 0.574),
	'width': TRACK_WIDTH,
	'z-index': 12
	},
	{ 'name': "track13",
	'color': (0.000, 0.723, 0.090),
	'width': TRACK_WIDTH,
	'z-index': 13
	},
	{ 'name': "track14",
	'color': (0.004, 0.813, 0.996),
	'width': TRACK_WIDTH,
	'z-index': 14
	},
	{ 'name': "track15",
	'color': (0.566, 0.813, 0.793),
	'width': TRACK_WIDTH,
	'z-index': 15
	},
	{ 'name': "track16",
	'color': (0.730, 0.531, 0.000),
	'width': TRACK_WIDTH,
	'z-index': 16
	},
	{ 'name': "track17",
	'color': (0.867, 0.996, 0.453),
	'width': TRACK_WIDTH,
	'z-index': 17
	},
	{ 'name': "track18",
	'color': (0.000, 0.996, 0.773),
	'width': TRACK_WIDTH,
	'z-index': 18
	},
	{ 'name': "track19",
	'color': (0.996, 0.895, 0.008),
	'width': TRACK_WIDTH,
	'z-index': 19
	},
	{ 'name': "track20",
	'color': (0.594, 0.996, 0.320),
	'width': TRACK_WIDTH,
	'z-index': 20
	},
	{ 'name': "track21",
	'color': (0.000, 0.996, 0.469),
	'width': TRACK_WIDTH,
	'z-index': 21
	},
	{ 'name': "track22",
	'color': (0.996, 0.430, 0.254),
	'width': TRACK_WIDTH,
	'z-index': 22
	},
	{ 'name': "track23",
	'color': (0.645, 0.996, 0.820),
	'width': TRACK_WIDTH,
	'z-index': 23
	},
	{ 'name': "track24",
	'color': (0.996, 0.691, 0.402),
	'width': TRACK_WIDTH,
	'z-index': 24
	},
	{ 'name': "track25",
	'color': (0.000, 0.605, 0.996),
	'width': TRACK_WIDTH,
	'z-index': 25
	},
    ]

    if len(sys.argv)<3:
      print("Usage: python MusAnimLauncher.py input.mid outputDirectory")
      sys.exit(1)
      return

    mid=sys.argv[1]

    lexer = MidiLexer()
    lexer.lex(mid)

    frames_dir = sys.argv[2]+os.sep
    os.makedirs(frames_dir)

    speed_map = [{'time': 0.0, 'speed': 4}]

    #dimensions = 426, 240
    dimensions = 720, 480
    #dimensions = 1920, 1080

    fps = 25
    #fps = 29.97

    renderer=MusAnimRenderer()
    renderer.introduction=False
    renderer.render(mid, frames_dir, tracks,
      speed_map=speed_map,
      dimensions=dimensions,
      min_pitch=lexer.minPitch-PITCH_GRACE,
      max_pitch=lexer.maxPitch+PITCH_GRACE,
      fps=fps)

if __name__ == '__main__':
    main()
