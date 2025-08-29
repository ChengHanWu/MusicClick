# Game Design Document

## Core Vision
**Rhythm & Groove** is a chill, peaceful rhythm-idle hybrid game where players create music through gameplay. The experience should feel like nurturing a living, breathing musical ecosystem.

## Game Identity
- **Name**: Rhythm & Groove / Beat Echo
- **Genre**: Rhythm/Idle Hybrid
- **Platform**: Steam (Windows Desktop)  
- **Engine**: Godot 4.4
- **Mood**: Peaceful, meditative, satisfying

## Core Gameplay Loop

### Active Play: Rhythm Tapping
- Players tap/click in rhythm to earn **Groove** (currency)
- Timing accuracy affects rewards: Perfect > Good > Miss
- Natural, organic sound sources (rain, frogs, forest sounds)
- BPM difficulty scaling for risk/reward gameplay

### Passive Play: Musical Ecosystem  
- Spend Groove to purchase virtual "instruments"
- Each instrument generates Groove passively over time
- Instruments contribute unique musical clips to background soundtrack
- Player's progress becomes an evolving, personalized music composition

### Meta Progression
- Instrument variety and costs create meaningful spending choices
- Background music complexity reflects player advancement
- Optional prestige system for long-term engagement

## Design Pillars

### 1. Musical Discovery
Every new instrument should add something beautiful and harmonious to the soundscape. Players discover new musical combinations through their purchasing choices.

### 2. Peaceful Progression  
No stress, no pressure. Players can engage actively for faster progress or let the game generate income passively. Both paths feel rewarding.

### 3. Natural Harmony
Sound design emphasizes natural, organic audio sources. The game world feels alive and connected to nature, not synthetic or artificial.

### 4. Personal Expression
The final musical composition is unique to each player's journey and choices. No two players will have exactly the same soundtrack.

## Audio Design Philosophy

### Sound Sources
- **Primary**: Natural environmental sounds (rain, streams, wind, animals)
- **Secondary**: Acoustic instruments with natural timbres
- **Avoid**: Electronic/synthetic sounds, harsh or jarring audio

### Musical Framework
- **Key**: C Major (accessible, harmonious)
- **Tempo Range**: 60-150 BPM (comfortable for most players)
- **Structure**: Layered loops that combine harmoniously
- **Volume**: Gentle, never overwhelming

### Adaptive Music System
- Background music evolves based on owned instruments
- Maximum 4-5 simultaneous audio layers to prevent chaos
- Intelligent mixing ensures harmonic compatibility
- Random variation prevents repetitive loops

## Player Experience Goals

### Immediate (First 5 minutes)
- "This rhythm feels good to tap along with"
- "The sounds are beautiful and calming"
- "I can see my progress growing"

### Short-term (30 minutes)  
- "My music is getting richer and more complex"
- "I want to unlock the next instrument to hear what it adds"
- "This is the perfect background activity"

### Long-term (Hours/Days)
- "I've created something uniquely beautiful"
- "I want to show others my musical creation"  
- "This is my go-to relaxation game"

## Technical Constraints
- Single-player experience (no multiplayer complexity)
- Runs smoothly on modest hardware
- Quick load times (under 3 seconds)
- Reliable save/load system for progression
- Steam integration for achievements/cloud saves