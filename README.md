#father's day jam - for nathan =]
started 05/05/2015

### ideas/concepts
top down walk around, roguelike
Travel across/through backyards. Each layout is different. Random. Tasks in each backyard:
-flip burger
-find baby, return to stroller
-avoid/destroy enemies

-tasks give you extra points, enemies give you experience.

Break through fence (3 hits/turns) to get to next backyard

upgradeable spatula/weapon
upgradeable apron/armor

### todo
* PlayerControlsGrid -> Input.hx - reads input, fires events that player and enemy listen for (took_a_step('direction'))
* new class - PlayerAction - listens for event, looks at tile in direction, decides action (walk, block, fight, etc)
* enemies still listen for the step event, do their thing
* turn/energy system
* get an enemy on screen, moves when/after player moves (events?)
* fix movement. arrows move one space at a time. no holding movement. touch/mouse to click on a spot and move multiple tiles.


### done (put a date!)