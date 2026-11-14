---

kanban-plugin: board

---

## Problems

- [ ] On the world map, if you spam click the map nodes the transition will reset itself early and you can stay prevent the transition
- [ ] Attack indicator isnt lined up for every unit, consider letting them store an (eye position) where the anim will sit (potentially also just keep it top right)
- [ ] If theres gaps in the map, movement and attacks highlight over it. use the astar2d and the unit position to calculate which of the tiles should be accessible and have a flag on highlight_tiles for over_gaps = false. And if false we skip over tiles inaccessible from the unit, else we do current method. (this could also mean a complete redo of our movement radius solving algorithm.)
- [ ] next turn may need to check if the current battle state is a win or loss (we could totally do this in the battle phase process)


## In Progress

- [ ] When attacking it still shows allied units, \#fixdat
- [ ] when you have more allies than enemies the enemies go first, you should let the player go first
- [ ] potentially update ability turn_state_process to not highlight units that arent effectables


## Fixed

- [ ] when an enemy unit dies, the turn order gets all wonky
- [ ] UNIT LOADER DOES NOT GO TO NEXT TURN, HANDLE IN BATTLE PHASE LOGIC
- [ ] ^^^ DO THIS
- [ ] REMOVE DEAD UNITS FROM THE POS DICTS
- [ ] tile under unit in attack gotta GO
- [ ] when you end your turn immediately after moving, a tile is leftover under you
- [ ] when an enemy kills a unit, the delay between them getting queue freed and the enemy calling next turn is out of sync. Maybe make a new flag, when a unit is killed it is immediately set to true. and that flag overrides all unit states
	
	ALTERNATIVELY:
	in enemy turn, check if unit killed is dead if so wait 0.8 to 1.2 seconds




%% kanban:settings
```
{"kanban-plugin":"board","list-collapse":[false,false,false]}
```
%%