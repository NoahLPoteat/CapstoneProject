
I need to decide if the open world aspect will be grid map, or freely built with the tilemap adhering itself to the world

I believe the second option will be best for the final product but the first would be easier to make something in general

Would is build however I wish, I want to study the deepwoken environment design for this. The large flat walls would make the verticality I wish for easier to reach (although not a requirement for the final project)

Theoretical process
One combat initiation
Define a combat radius at progenation point
Rune a downward facing raycast loop in a sphere of that radius
Clamp all those rays to fit a grid, where each tile has a height and an A* 3d generated for it (tiles need to be on the ground)
Also check if the tile has anything its colliding with (such as a tree or something of the sort) and although not important at first if there is something in the way, ensure that thing blocking cant be a tile itself

^^ UPDATE

Instead of a sphere, we use a circle or another shape planar to the x y axis and send it upward

When the ray goes down, we document all terrain, form the grid with clamp and run it all into an A* 3D
We then go from progenation point and clean up the A* 3D and get rid of all the points that cant be reached in the battle

This should allow us to use a non tile based terrain with a tile based combat system.
Now I just have to see if it looks good