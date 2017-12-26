/*
 
TO DO LIST
__________________
 1: Setup entity collision recognition
    * when an Orb collides with a player, the players life count should go down
    - when an orb collides with another orb, they should both blow up using particles
 
 2: Player Movement
    * setup system for detecting swipes and move a player in that direction
    - setup 9 tile entities on the the screen in a 3x3 box to start
    - create a system for removing and re-spawning tiles
 
 
        RULES FOR TILE SPAWNS
        ---------------------
        - A tile can only respawn in the field of view.
        - A tile must share at least one side with another tile
        - Only Edge tiles can be respawned, there should not be any holes in the tile configuration
 
 3: Player - Tile relationship
    - make it so that a player can only move from tile to tile
 
 
 4: Scoring
    * A player should start the game with 3 lives, Orbs subtract from that as they collide with the player
    - Score should be updated constantly in milliseconds
    - The game is over when a player loses 3 lives
 
 5: Implement Levels
    - Levels use the same game but variables will change making it harder
    - Orb shooting speed overall should be randomized, as levels go up the potential top speed will rise
    - Orb Spawning frequency will continue to be done randomly
 
 

 
 
 
 
 
 PART 2 - Finish Up
 ======================
  * Rotate character in direction of swipe and the nmake him upright again
  * Keep track of prizes and remove them when they are caught
  * Set a variable limit of prizes (init to 5)
  * show 3 small lives in the top right corner under the score and update them as orbs hit the player
  - setup randomness for:
    == Prizetypes (icon and prize value should match)
    == Prize Color (images, and image names may need to be changed)
 
  - Create the end of the game
    == Setup the end of game scene
        Show Final Score
        Show Start Over
 
 
 
 
 
 Part 3 - Game Center Integration
 ==================================
 TBD
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */


