# Game Test
### Board Setup
Each of the two players has his six pits in front of him. To the right of the six pits, each player has a larger pit. In each of the six round pits are put six stones when the game starts.
### Rules
#### Game Play
The player who begins with the first move picks up all the stones in anyone of his own six pits, and sows the stones on to the right, one in each of the following pits, including his own big pit. No stones are put in the opponents' big pit. If the player's last stone lands in his own big pit, he gets another turn. This can be repeated several times before it's the other player's turn.
#### Capturing Stones
During the game the pits are emptied on both sides. Always when the last stone lands in an own empty pit, the player captures his own stone and all stones in the opposite pit (the other players' pit) and puts them in his own pit.
#### The Game Ends
The game is over as soon as one of the sides run out of stones. The player who still has stones in his pits keeps them and puts them in his/hers big pit. Winner of the game is the player who has the most stones in his big pit.


### Files
```
/lib/game.rb
```
contains the rules and handling of the game concepts

```
/app/views/home.html.erb
```
contains the front-end code of the game
```
/app/controllers/home_controller.rb
```
contains the code to call game class for the front end to use

### See it in action
https://game-sulman.herokuapp.com/
