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
│   ├── main.tscn            # Main game scene (Week 2 complete with shop integration)
│   ├── instruments/         # Instrument-related scenes (empty - Week 3+)
│   ├── rhythm_game/         # Core rhythm gameplay scenes (empty)
│   └── ui/                  # User interface scenes
│       └── shop_panel.tscn  # Shop panel UI for instrument purchases
├── scripts/                 # GDScript files
│   ├── core/                # Core game systems
│   │   ├── InputJudge.gd    # Input timing judgment system
│   │   └── Metronome.gd     # Global timing system (singleton)
│   ├── game/                # Main game logic
│   │   ├── CurrencyManager.gd # Groove currency & passive income system (singleton)
│   │   ├── GameManager.gd     # Main game coordinator
│   │   ├── RhythmController.gd # Rhythm game controller
│   │   └── ShopManager.gd     # Instrument shop system (singleton)
│   ├── instruments/         # Instrument implementations
│   │   ├── Instrument.gd      # Base instrument class
│   │   └── DrumMachine.gd     # Drum machine instrument (Week 2)
│   └── ui/                  # UI controllers
│       └── HUDController.gd # UI updates, animations, and shop interactions
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

## Key System Locations ✅ IMPLEMENTED (Week 2)
- **Core Rhythm Logic**: `scripts/core/` ✅ (InputJudge.gd, Metronome.gd complete)
- **Game State Management**: `scripts/game/GameManager.gd` ✅ (fully implemented)
- **Currency System**: `scripts/game/CurrencyManager.gd` ✅ (with passive income generation)
- **Shop System**: `scripts/game/ShopManager.gd` ✅ (instrument purchasing system)
- **Instrument System**: `scripts/instruments/` ✅ (base class + DrumMachine implemented)
- **Main Game Scene**: `scenes/main.tscn` ✅ (rhythm game + shop panel integrated)
- **Shop UI**: `scenes/ui/shop_panel.tscn` ✅ (purchase interface complete)
- **Audio Assets**: `audio/instruments/drums/` ✅ (placeholder .ogg files ready for replacement)

## Development Notes
- Use Godot 4.4 with GL Compatibility renderer
- Target platform: Steam (Windows Desktop)
- Main scene entry point: `res://main.tscn`
- Build output: `builds/` directory

## Current Project State - Week 2 Demo Complete
- **Scripts**: All Week 2 core systems implemented and ready
  - ✅ Metronome system with precise 90 BPM timing
  - ✅ Currency Manager with passive income generation
  - ✅ Input Judge for timing accuracy detection
  - ✅ Rhythm Controller connecting all systems
  - ✅ HUD Controller with shop interactions and passive income display
  - ✅ Game Manager coordinating everything
  - ✅ Shop Manager singleton for instrument purchases
  - ✅ Instrument base class and DrumMachine implementation
- **Scenes**: Main game scene with shop panel integrated
- **Audio**: Placeholder audio files in place (need real .ogg files)
- **Functionality**: Complete Week 2 hybrid experience - active play funds passive income

## Current Development Status
- **Week 2 Demo: "Your First Band Member"** ✅ COMPLETE
- **Next Target**: Week 3 Demo - "Growing Your Sound" (multiple instruments, layered audio)