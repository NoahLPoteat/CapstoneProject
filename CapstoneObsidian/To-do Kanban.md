---

kanban-plugin: board

---

## Todo - Stretch

- [ ] override mouse to custom mouse
- [ ] Rewrite hovering_tile in battle_map_controller to use the highlight_tile function
- [ ] Make units play a little animation on death
- [ ] implement a white flash shader on unit damage taken
- [ ] progression line between map nodes with fun little animation
- [ ] damage numbers


## Todo

- [ ] Implement middle mouse hold panning with bounds for the battlemap
- [ ] Implement Placement Phase
- [ ] Modify Battle Maps to have certain tiles be marked as available for starting placement
- [ ] Adjust placement phase to limit which tiles can be placed on (consider using custom tile data)
- [ ] Make the AI follow the closest unit, and attack it off cooldown.
- [ ] Add logic for unit abilities and ability selection (doesnt have to actually be unique but get logic there)
- [ ] Add arrow indicator for current unit
- [ ] Create tech demo video, push an update to itchio, and make a devlog


## in-progress

- [ ] update current world node system to push the battle map to the battle screen (instead of loading the default one)
- [ ] finish battle maps check_win_loss, and add functionality for wins to progress the world map


## complete

- [ ] add functionality to "unlock" the next node
- [ ] Adjust map nodes to take a battle map and a progress_node
- [ ] Add basic AI for enemy units (and the pipeline for enemy AI) that makes them just move to a random spot in range and end their turn
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