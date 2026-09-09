
The world map system at its core, needs to be a 2d background image with a chain of nodes. Each of those nodes needs to have click detection, and needs a linked battlemap. They need to be connected by a parent node that will control what stage of the linear progression the user is at.
When one node is "completed" the next needs to be reveals and the path2D between them needs to slowly fill up.
From this we may want to add support for the multiple acts that will be coming later.

Below is a checklist of the requirements for this to be done (updated as needed)

  - [ ] Background Image, static sprite for now
  - [ ] Nodes that have click detection and a corresponding battle map
  - [ ] Parent node for the map nodes that has logic to connect them and progress the maps
  - [ ] Add path 2D between the nodes that grows when progress happens
  - [ ] Support for dialogue before and after the battle
  - [ ] Update to the background to either be animated, or have a fun shader (extra)