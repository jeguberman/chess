# CHESS
Chess is a CLI version of the classic game chess, for 2 players. The purpose of chess was to display my familiarity with class interactions in ruby.

## To Play Chess

OSX- Make sure you have ruby 2.4 installed. Simply clone Chess into it's own repository, navigate to the root folder and type

      ruby chess.rb

## Flow of Play
  If you don't know how to play chess, you can learn more [here](https://www.wikihow.com/Play-Chess).

  2 players (white and black) take turns moving one piece at a time. White always goes first. The current player is listed on the bottom of the board.
  When the cursor is red, you can select one of your own pieces.


  ![](/assets/Screen Shot 2018-01-17 at 10.42.12 AM.png)






  Once you have selected your piece, the cursor turns green, and you can select the square you want to move your piece to.


  ![](/assets/Screen Shot 2018-01-17 at 10.43.56 AM.png)

  If you make an illegal selection, you should receive an error message

  ![](/assets/Screen Shot 2018-01-17 at 10.43.56 AM.png)


  You can quit at any time with ctrl+c

## TODO

  * Pieces should only be able to move in accordance to their definitions
  * Error messages should be more specific
  * You should not be able to select a "destination square" if you haven't selected one of your own pieces
  * When you select your piece, the board should highlight available squares.
    * The cursor should move between those squares
  * Add a simple Chess AI that optimizes for the CURRENT move. (Easy mode)



## Technologies
Chess was written in Ruby and uses the Colorize gem.

[colorize](https://github.com/fazibear/colorize)

cursor.rb was provided by App Academy with the exception of the handle_key, toggle_background, and update_pos methods, as well as the instance variables in initialize.
