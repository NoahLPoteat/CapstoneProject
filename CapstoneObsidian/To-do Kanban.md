---

kanban-plugin: board

---

## Todo

- [ ] Display Unit Stats on turn change
- [ ] Implement the battle phases
- [ ] Implement unit placement at the start of a fight
- [ ] Add basic AI for enemy units (and the pipeline for enemy AI) that makes them just move to a random spot in range and end their turn
- [ ] Implement middle mouse hold panning with bounds for the battlemap
- [ ] Adjust placement phase to limit which tiles can be placed on (consider using custom tile data)
- [ ] Add logic for unit abilities and ability selection (doesnt have to actually be unique but get logic there)
- [ ] Add functionality for units to take damage
- [ ] Make Strike and Ability button change unit state, and display valid tiles for said ability (may be worth keeping that logic in the ability itself)
- [ ] Add Particle effect on ability hit
- [ ] Create tech demo video, push an update to itchio, and make a devlog
- [ ] Make the AI follow the closest unit, and attack it off cooldown.
- [ ] Update Next Turn to only allow player to end turn on their turn


## in-progress

- [ ] Add button for end turn


## complete

- [ ] Setup basic Unit Retrieval and turn order
- [ ] Highlight tile that is hovered by curser
- [ ] Add ability for unit to move on click (will be repurposed later for real movement)
- [ ] Send current unit data up to displays, on turn change and on UI update
- [ ] Calculate and highlight tiles within movement range of unit
- [ ] Edit so units cannot overlap tiles
- [ ] setup unit turn state (+ enum), draw up FSM for it
- [ ] Place Units based on their Default Positions
- [ ] Finish itch.io devlog of the tactical walking sim




%% kanban:settings
```
{"kanban-plugin":"board","list-collapse":[false,false,false]}
```
%%