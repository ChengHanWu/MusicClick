# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Rhythm & Groove** is a peaceful rhythm-idle hybrid game where players tap along to natural sounds to earn currency and build a virtual musical ecosystem.

## Documentation Structure

This project uses organized documentation files:

- **`docs/DEVELOPMENT_PLAN.md`** - PM-oriented demoable feature development plan
- **`docs/GAME_DESIGN.md`** - Core game design document and vision  
- **`docs/PROJECT_STRUCTURE.md`** - Current folder structure reference
- **`docs/TECHNICAL_SPECS.md`** - Technical implementation details and commands

## Development Approach

### Feature-Driven Development Cycle
1. **Plan**: Reference next demoable feature from `docs/DEVELOPMENT_PLAN.md`
2. **Structure**: Check current organization in `docs/PROJECT_STRUCTURE.md`
3. **Design**: Create technical implementation plan
4. **Build**: Implement the feature following Godot best practices
5. **Demo**: Test playability and get feedback
6. **Update**: Refresh folder structure documentation

### Quick Start Commands
```bash
# Run the project
godot --path . --main-scene res://main.tscn

# Export Windows build  
godot --headless --export-release "Windows Desktop" builds/rhythmclick.exe
```

## Current Focus

We're following a **demoable feature approach** where each week delivers a playable experience that can be demonstrated and tested. See `docs/DEVELOPMENT_PLAN.md` for the complete roadmap.

### Next Target: Week 1 Demo - "The Basic Beat"
Create a simple rhythm tapping interface where players earn Groove currency by clicking in time with a pulsing beat.

## Legacy Reference

The detailed technical development plan and TODO lists have been moved to organized documentation files in the `docs/` folder for better maintenance and clarity.