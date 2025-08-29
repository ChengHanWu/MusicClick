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
│   ├── main.tscn            # Main game scene (Week 1 complete)
│   ├── instruments/         # Instrument-related scenes (empty - Week 2+)
│   ├── rhythm_game/         # Core rhythm gameplay scenes (empty)
│   └── ui/                  # User interface scenes (empty)
├── scripts/                 # GDScript files
│   ├── core/                # Core game systems
│   │   ├── InputJudge.gd    # Input timing judgment system
│   │   └── Metronome.gd     # Global timing system (singleton)
│   ├── game/                # Main game logic
│   │   ├── CurrencyManager.gd # Groove currency system (singleton)
│   │   ├── GameManager.gd     # Main game coordinator
│   │   └── RhythmController.gd # Rhythm game controller
│   ├── instruments/         # Instrument implementations (empty - Week 2+)
│   └── ui/                  # UI controllers
│       └── HUDController.gd # UI updates and animations
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

## Key System Locations ✅ IMPLEMENTED (Week 1)
- **Core Rhythm Logic**: `scripts/core/` ✅ (InputJudge.gd, Metronome.gd complete)
- **Game State Management**: `scripts/game/GameManager.gd` ✅ (fully implemented)
- **Currency System**: `scripts/game/CurrencyManager.gd` ✅ (singleton implemented)
- **Main Game Scene**: `scenes/main.tscn` ✅ (working rhythm game interface)
- **Audio Assets**: `audio/instruments/[instrument_name]/` (folders exist, placeholder audio in use)

## Development Notes
- Use Godot 4.4 with GL Compatibility renderer
- Target platform: Steam (Windows Desktop)
- Main scene entry point: `res://main.tscn`
- Build output: `builds/` directory

## Current Project State - Week 1 Demo Complete
- **Scripts**: All Week 1 core systems implemented and ready
  - ✅ Metronome system with precise 90 BPM timing
  - ✅ Currency Manager for Groove points 
  - ✅ Input Judge for timing accuracy detection
  - ✅ Rhythm Controller connecting all systems
  - ✅ HUD Controller for UI updates and animations
  - ✅ Game Manager coordinating everything
- **Scenes**: Main game scene with pulsing circle interface ready
- **Audio**: Placeholder audio files in place (need real .ogg files)
- **Functionality**: Basic rhythm tapping game ready for testing

## Update Log
- **2024-12-29**: Updated PROJECT_STRUCTURE.md to reflect actual current state (post-rollback)
- **2024-12-29**: Week 1 Demo "The Basic Beat" implementation completed ✅
- **2024-12-29**: Week 1 Demo tested and confirmed working - 100+ Groove in 30 seconds achievable ✅
- **Next Update**: Ready for Week 2 Demo implementation - "Your First Band Member"