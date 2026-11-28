---

kanban-plugin: board

---

## Todo - Stretch

- [ ] reroute enemy ai to be tied to the enemy itself
- [ ] Make the battle gui panel (the one that shows the unit and abis) tween out of the side after you load into battle, then make the placement + abi select come out after
- [ ] Consider making the battle gui have equal padding on both sides
- [ ] Add arrow indicator for current unit
- [ ] add a visual to the end of the battle screen when battle won / lost
- [ ] override mouse to custom mouse
- [ ] Rewrite hovering_tile in battle_map_controller to use the highlight_tile function
- [ ] Make units play a little animation on death
- [ ] implement a white flash shader on unit damage taken
- [ ] progression line between map nodes with fun little animation
- [ ] damage numbers
- [ ] make a cool shader for the win loss
- [ ] add functionality for a small cinematic when a map is loaded
- [ ] make camera pan / center to current unit when the turn changes
- [ ] Adjust Fights to allow for an enemies first toggle
- [ ] Add saving funtionality
- [ ] Create tech demo video, push an update to itchio, and make a devlog


## Todo

- [ ] Change the border to be global
- [ ] make 6 unique enemies (make 2 or 3 fodder types)
- [ ] Implement middle mouse hold panning with bounds for the battlemap
- [ ] Fully Populate each battlemap with enemies
- [ ] Finish sprites for Ability selection box
- [ ] Add the polish to the main menu
- [ ] Make a godot splash screen (just pixel robot face laughing or something with MADE IN GODOT under it)
- [ ] Start Tech Doc (do a rough outline)
- [ ] Start Slideshow (rough outline)
- [ ] Replace default splash screen with the border + blank screen.
- [ ] After splash screen, play a cartridge insert animation, followed by making the lights in the bottom right animate. Then play a startup sound transition to the custom made in godot splash. Then transition to the title screen and play the menu music


## in-progress

- [ ] Make the 3 other units you'll be given
- [ ] Finish custom abilities for each play unit (don't make any for enemies yet they wont have the ai to use them)
- [ ] Fill each battlemap with enemy units
- [ ] Make all the maps a have custom shapes
- [ ] Make a autoload for a future sound system that the options menu modifies
- [ ] Fill out the options menu
- [ ] Fill out the credits menu
- [ ] Add placement zones to each battlemap
- [ ] Modify Abilities to have a sprite that appears in the choice box
- [ ] Add a title song, world map song, and finally an in battle song (modify battle maps to allow different maps to have different songs)


## complete

- [ ] Add battlemaps to each mapnode
- [ ] Give stages the ability to give a unit after
- [ ] Make a basic title screen that transitions to the world map
- [ ] YOU FORGOT TO ADDDDD MANA COSTSS TO THE ABILITIES YOU BUFFOON
- [ ] Add functionality to start and exit buttons in the main menu
- [ ] Add functionality to the credits and options button (screen transition and whatnot)
- [ ] Implement a static tile screen with fake buttons
- [ ] Add name desc and other information into the proper areas
- [ ] Modify the abi selection box to have 2 buttons (similar to other buttons currently used) that changes the units chosen ability
- [ ] Add the abi selection bg sprite to godot and have it appear during the placement phase
- [ ] Once Abilities are added, update unit placement to have a choice box appear next to the top unit to choose the ability
- [ ] add some basic abilities for testing
- [ ] Modify Map reset to move ally units back off screen before the battle (maybe -100 -100 to be safe)
- [ ] Implement Placement Phase
- [ ] implement attempt_place_unit
	a wrapper for attempt move unit that checks if the tile is placeable first and then moves the unit to said tile if so (it should also probably emit a signal or return a bool) when successful we need to update the placeables array to not have that unit anymore
- [ ] update _unhandled_input_ to match between the battlephases and on placement should use the click to attempt_place_unit at that position
- [ ] Adjust placement phase to limit which tiles can be placed on (consider using custom tile data)
- [ ] Modify Battle Maps to have certain tiles be marked as available for starting placement
- [ ] Fix battles so you cant skip enemy turns with the next turn button (consider enemy override in the next_turn)
- [ ] update battle_map_controller to queue.free old maps when the battle is over
- [ ] update battle_map_controller to load a map node instead of a default node
- [ ] connect the game node win loss detection down to world map controller, and perform a transition to it.
- [ ] Link battle map win loss, to a win loss screen, and then up to the game node
- [ ] update current world node system to push the battle map to the battle screen (instead of loading the default one)
- [ ] finish battle maps check_win_loss,
- [ ] add functionality to "unlock" the next node
- [ ] Adjust map nodes to take a battle map and a progress_node
- [ ] Add basic AI for enemy units (and the pipeline for enemy AI) that makes them just move to a random spot in range and end their turn
- [ ] Make the AI follow the closest unit, and attack it off cooldown.
- [ ] Update Next Turn to only allow player to end turn on their turn
- [ ] Implement the battle phases
- [ ] implement death animation
- [ ] implement death
- [ ] Add Particle effect on strike
- [ ] Add functionality for units to take damage
- [ ] Make Strike and Ability button change unit state, and display valid tiles for said ability (may be worth keeping that logic in the ability itself)
- [ ] Add some sort of visual to indicate whether or not the unit can attack still
- [ ] Display Unit Stats on turn change
- [ ] Setup basic Unit Retrieval and turn order
- [ ] Highlight tile that is hovered by curser
- [ ] Add ability for unit to move on click (will be repurposed later for real movement)
- [ ] Send current unit data up to displays, on turn change and on UI update
- [ ] Calculate and highlight tiles within movement range of unit
- [ ] Edit so units cannot overlap tiles
- [ ] setup unit turn state (+ enum), draw up FSM for it
- [ ] Place Units based on their Default Positions
- [ ] Finish itch.io devlog of the tactical walking sim
- [ ] Add button for end turn




%% kanban:settings
```
{"kanban-plugin":"board","list-collapse":[false,false,false,false]}
```
%%