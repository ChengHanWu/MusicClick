# Project Structure Reference

## Current Folder Organization

```
rhythmclick/
├── docs/                     # Documentation files
│   ├── DEVELOPMENT_PLAN.md   # PM-oriented feature development plan
│   ├── GAME_DESIGN.md        # Core game design document  
│   ├── PROJECT_STRUCTURE.md  # This file - current folder structure
│   └── TECHNICAL_SPECS.md    # Technical implementation details
├── assets/                   # Game assets
│   ├── effects/             # Visual effects and particles
│   ├── temp/                # Temporary development assets
│   └── ui/                  # UI elements and sprites
├── audio/                   # Audio files
│   ├── feedback/            # UI and gameplay feedback sounds
│   ├── instruments/         # Instrument audio clips
│   │   └── drums/           # Drum machine audio files
│   └── metronome/           # Metronome and timing sounds
├── builds/                  # Compiled game builds
│   └── windows/             # Windows platform builds
├── scenes/                  # Godot scene files (.tscn)
│   ├── instruments/         # Instrument-related scenes
│   ├── rhythm_game/         # Core rhythm gameplay scenes
│   └── ui/                  # User interface scenes
├── scripts/                 # GDScript files
│   ├── core/                # Core game systems
│   │   ├── InputJudge.gd    # Input timing judgment
│   │   ├── Metronome.gd     # Global timing system
│   │   └── RhythmData.gd    # Rhythm pattern data structures
│   ├── game/                # Main game logic
│   │   ├── CurrencyManager.gd # Groove currency system
│   │   ├── GameManager.gd     # Overall game state management
│   │   └── RhythmController.gd # Rhythm game controller
│   ├── instruments/         # Instrument implementations
│   │   ├── DrumMachine.gd   # Drum machine instrument
│   │   └── Instrument.gd    # Base instrument class
│   └── ui/                  # UI controllers
│       ├── HUDController.gd # Main HUD display
│       └── ShopController.gd # Instrument shop interface
├── CLAUDE.md               # Main Claude Code guidance file
├── icon.svg               # Project icon
├── icon.svg.import        # Godot import settings for icon
└── project.godot          # Godot project configuration
```

## File Naming Conventions
- **Scripts**: PascalCase with descriptive names (e.g., `RhythmController.gd`)
- **Scenes**: snake_case matching their purpose (e.g., `rhythm_game.tscn`)
- **Assets**: snake_case with category prefixes (e.g., `drum_kick_120bpm.ogg`)
- **Documentation**: UPPERCASE with underscores (e.g., `GAME_DESIGN.md`)

## Key System Locations
- **Core Rhythm Logic**: `scripts/core/`
- **Game State Management**: `scripts/game/GameManager.gd`
- **Currency System**: `scripts/game/CurrencyManager.gd`  
- **Main Game Scene**: `scenes/main.tscn` (to be created)
- **Audio Assets**: `audio/instruments/[instrument_name]/`

## Development Notes
- Use Godot 4.4 with GL Compatibility renderer
- Target platform: Steam (Windows Desktop)
- Main scene entry point: `res://main.tscn`
- Build output: `builds/` directory

## Update Log
- **Current**: Initial project structure established
- **Next Update**: After completing Week 1 demo implementation