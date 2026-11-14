---

kanban-plugin: board

---

## Todo - Stretch

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

- [ ] YOU FORGOT TO ADDDDD MANA COSTSS TO THE ABILITIES YOU BUFFOON
- [ ] make 6 unique enemies (make 2 or 3 fodder types)
- [ ] Give stages a potential for a pre/post fight cutscene (animated sprite and just do it manually)
- [ ] Give stages the ability to give a unit after
- [ ] Make a basic title screen that transitions to the world map
- [ ] reroute enemy ai to be tied to the enemy itself
- [ ] Increase size of abi selection box to accommodate more text in the description (4 words aint enough)


## in-progress

- [ ] Once Abilities are added, update unit placement to have a choice box appear next to the top unit to choose the ability
- [ ] Modify Abilities to have a sprite that appears in the choice box
- [ ] Finish sprites for Ability selection box
- [ ] Add the abi selection bg sprite to godot and have it appear during the placement phase
- [ ] Modify the abi selection box to have 2 buttons (similar to other buttons currently used) that changes the units chosen ability
- [ ] Add name desc and other information into the proper areas
- [ ] Implement middle mouse hold panning with bounds for the battlemap


## complete

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