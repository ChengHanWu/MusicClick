# Technical Specifications

## Engine & Platform
- **Engine**: Godot 4.4 
- **Renderer**: GL Compatibility (for broader hardware support)
- **Target Platform**: Steam (Windows Desktop)
- **Minimum System Requirements**: Windows 10, 2GB RAM, DirectX 11

## Development Commands

### Running the Project
```bash
# Open in Godot Editor
godot --editor --path .

# Run game directly  
godot --path . --main-scene res://main.tscn

# Run in editor (F5 key)
```

### Building & Export
```bash
# Export Windows release build
godot --headless --export-release "Windows Desktop" builds/rhythmclick.exe

# Export debug build
godot --headless --export-debug "Windows Desktop" builds/rhythmclick-debug.exe
```

## Core Systems Architecture

### Rhythm System
- **Global Metronome**: Precise timing system supporting variable BPM
- **Input Judge**: Timing window detection (Perfect/Good/Miss)
- **Pattern Data**: Dictionary-based rhythm pattern definitions
- **State Machine**: "Cue → Countdown → Input → Evaluation" cycle

### Economy System  
- **Currency Manager**: Groove generation, spending, and balance tracking
- **Cost Scaling**: Mathematical progression for instrument pricing
- **Passive Income**: Time-based Groove generation from owned instruments

### Audio System
- **Adaptive Mixing**: Dynamic audio layer management
- **Clip Management**: Multiple BPM versions of each instrument audio
- **Global Conductor**: Synchronized playback timing across all instruments
- **Audio Pool**: Efficient memory management for sound clips

### Data Management
- **Save/Load System**: JSON-based player progress persistence
- **Settings Management**: Audio, input, and display preferences
- **Analytics**: Optional telemetry for balance tuning

## File Structure Standards

### Script Organization
```
scripts/
├── core/           # Engine-level systems
├── game/           # Game logic and state
├── instruments/    # Instrument implementations  
├── ui/             # Interface controllers
└── utils/          # Helper functions and utilities
```

### Asset Organization
```
assets/
├── audio/          # All audio files
│   ├── instruments/    # Organized by instrument type
│   ├── feedback/       # UI and gameplay sounds
│   └── ambient/        # Environmental audio
├── ui/             # Interface graphics
└── effects/        # Visual effects and particles
```

### Scene Structure
```
scenes/
├── main.tscn           # Primary game scene
├── rhythm_game/        # Rhythm minigame components
├── instruments/        # Individual instrument scenes
└── ui/                # Interface scenes
```

## Performance Targets
- **Frame Rate**: Stable 60 FPS on target hardware
- **Memory Usage**: < 512 MB RAM
- **Load Time**: < 3 seconds from launch to playable
- **Audio Latency**: < 50ms input to audio feedback
- **File Size**: < 100 MB total download

## Development Workflow Integration
Each feature development follows this technical cycle:

1. **Design Review**: Reference GAME_DESIGN.md for feature requirements
2. **Structure Planning**: Update PROJECT_STRUCTURE.md with new files/folders  
3. **Implementation**: Follow Godot best practices and existing code patterns
4. **Testing**: Verify performance targets and functionality
5. **Documentation**: Update relevant .md files with changes

## Code Standards
- **Language**: GDScript (primary), C# (if performance critical)
- **Naming**: PascalCase for classes/methods, snake_case for variables
- **Documentation**: Inline comments for complex algorithms
- **Version Control**: Git with clear commit messages
- **Testing**: Manual testing focus, automated tests for core systems