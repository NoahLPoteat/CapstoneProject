# Working Title

# High Level

## Concept Statement
Permadeath PvE semi open world tactics rpg. Broad build mechanics to promote large diversity between characters and units. Many of the mechanics and systems will be shrouded 


# Product Design

## Game World Fiction
A collection of various sized islands, traversed between easily via boat. Different clusters of islands will house different factions. Regions will also have different main power systems (with some overlap areas). 
The two main points of geo-political conflict come from the civil war in the larger south eastern empire. And the grafters of the north east.
These are not the only (antagonizing) forces in the world, but they are the main ones I will focus on for the project.

## Monetization
This is largely undecided for now
As more mechanics come in, pathways for monetization may show themselves.
For now an upfront cost seems good enough, especially since most servers (I may host some official ones) will be user hosted.

## Platforms, Tech, Scope
PC, 3D, Godot

Realistically 4 to 5 years to make with one person (with a few extra month for design)
With more people the could go down though

An early gameplay loop prototype would only take 6ish months 
(I've build a tactics rpg in 3 before)

## Core Loops

The main game loop is explore, progress items and character, and the end game involves some bosses and story content. This loop is perpetuated by optional perma-death.


# Detailed Game System Design

## Objectives and Progression
### Movement
The player will move through the game on land with sprinting, walking, (air) dashing, and any mobility based abilities they may have.

To move between islands the player will go to specified docks throughout the world map

## High Level Feature List
	Entity System
	Isometric Character Controller
	Party Management System
	Isometric Game Map
	Free Move Game Map to Tile Locked Tactics System
	Dashing / Climbing / Advanced Movement
	Character Stat / Level System
	Equipment
	Item Resource (usable and un-usable)
	Inventory GUI
	Storage Containers / External Inventories
	Hotbar GUI
	Passive Abilities and Status Effects
	Persistent Buffs / Debuffs (modifiers?)
	Brand
	Active Abilities 
	Resource Bars
	Character Pages
	Classes
	Class Progression Trees
	Currency
	Reputation
	NPC entity types
	Hostile / Neutral / Docile Entity types
	Shops
	Branching Dialogue System with Triggers
	Quests System with triggers able to used in a variety of ways


## Game Systems

Split by 7 core pillars, and then by priority tier

Each of these will have more detail on implementation when I make a .md for each layer
### Exploration / Roaming

#### High
Isometric Character Controller
	Walking, Sprinting, Collisions, Slopes, Stairs

Entity Navigation / Navmesh
	Navigation mesh or grid based pathing for all world entitys

Isometric Camera
	Wall / Tree occlusion
	Zoom / Rotation
	Follow vs Locking

Interaction System
	talking
	doors
	containers
	docks
	any interactable

World Entity Spawner
	Spawn / Despawn enemies
	Handle Conditional Spawning (for bosses / quests)
	NPCS
	Props
	Island Loading

World Layer AI
	Movement
	Wander
	Patrol
	Aggro
	Chase
	Leash

Dock / Boat Travel
	Dock Interaction
	Boat Purchasing
	Destination Picker*
	Ocean Travel*
	Ocean Threats*
	Ocean Battles*
*(This one is odd, part of me wants to just have a world map you teleport around on after a travel sequence.
Another part wants to have a full scale world travel to add to exploration
perhaps world map + true boat travel)

#### Medium
Advanced Movement
	Dashing
	Climbing
	Stamina / Cooldowns (probably determined by stats)
	Mobility Abilities (tied to hotbar / Ability bar most likely)

Party Following Behavior
	Trailing Follow vs FF style
(I think followers will be a more ambiguous thing that can join you in fights)

Environmental Hazards
	Both surface and Volumetric
	Damaging clouds / zones
	Traversal Gates (cliffs, prog locks)
	Triggerable Hazards (traps)
(also will exist in tactics map)

Potential World Map
	Discovered Areas
	Points of Interest
	Placeable Markers

#### Low
Fog Of War
	If world map exists

Day / Night Cycle
	Time of day / Lighting 

Weather
	Weather effect depending on area and chance
	Useful for potential weather based encounters
	(IE bosses that only spawn in the rain)


### Tactics / Locked

#### High

Transition from free move to locked
	Snapping units to tiles
	Determining battlefield
	Pulling in nearby units

Tile grid | Pathfinding}
	Movement Cost
	Height
	Tile material / Hazardous tiles (shared with free)

Turn Order Calculations
	Determine turn order through stats
	Handle ties
	Handle insertion of new units

Action Economy
	Action Points
	Movement Points
	Actions Types

Targeting and LOS
	Calculate valid targets
	Within range
	Within sight (variable)

AOE Shape Library
	Save time for future when abilities may have different shapes
	Lines, Circles, Cones (needs to work in 3d which may be ball ass)
	Handle Rotation

Hit and Damage Resolution
	Criticals
	Damage Formula
	Mitigation
	Evasion

Damage Types and Resistances
	Weaknesses
	Resistances
	Damage Types
	Immunities
	Penetration

Encounter State Machine
	win / loss
	retreat / flee
	bodies

Data Driven Enemy AI
	Drag n Drop ECS
	Target Scoring
	Positioning
	Difficulty Consideration

Combat Camera
	Transition Camera control from character to the battle
	Focus on active unit / targeted unit

In-Combat Hud
	Turn Order Display
	Status Icons

Encounter Rewards
	Individual Enemy loot rolling
	Encounter Chests / Loot Boxes
	XP rewarding*
	Rep Payout
*XP may be tied to the use of abilities and actions as well as a general reward on defeating an enemy / completing quests

Combat Log
	Debug Panel
	Displays info for past turns

Dynamic Encounter Builder
	Phases
	Spawners
	Dialogue
	Transformations

#### Med

Terrain, Height
	Terrain consideration
	Cover bonuses
	Height
	Elevation Advantage

Reactions & Interrupts
	Out of Turn Interactions
	Trigger based responses
	Counter Attacks

Forced Movement
	Pushing
	Pulling
	Position Swapping
	Teleporting
	Collision Damage

Boss Encounter Builder
	Phases
	Dialogue
	Arena Tranformations
	Arena Hazards
	Unique Mechanics 

Combat Animation And VFX instancing

#### Low

Summons & Temp Units
	Ownership
	Lifetime

### Build / Unit Progression

#### High

Entity / Unit System
	Base Stats
	Resource

### World / Content

### Meta / User

### Permadeath 

### Networking

### Production / UX