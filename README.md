# CHESS
Chess is a CLI version of the classic game chess, for 2 players. The purpose of chess was to display my familiarity with class interactions in ruby.

## To Play Chess

OSX- Make sure you have ruby 2.4 installed. Simply clone Chess into it's own repository, navigate to the root folder and type

      ruby chess.rb

## Flow of Play
  If you don't know how to play chess, you can learn more [here](https://www.wikihow.com/Play-Chess).

  2 players (white and black) take turns moving one piece at a time. White always goes first. The current player is listed on the bottom of the board.
  When the cursor is red, you can select one of your own pieces.


  ![](https://raw.githubusercontent.com/jeguberman/chess/master/assets/Screen%20Shot%202018-01-17%20at%2010.42.12%20AM.png)






  Once you have selected your piece, the cursor turns green, and you can select the square you want to move your piece to.


  ![](https://raw.githubusercontent.com/jeguberman/chess/master/assets/Screen%20Shot%202018-01-17%20at%2010.44.21%20AM.png)

  If you make an illegal selection, you should receive an error message

  ![](https://raw.githubusercontent.com/jeguberman/chess/master/assets/Screen%20Shot%202018-01-17%20at%2010.43.56%20AM.png)


  You can quit at any time with ctrl+c





## Technologies
Chess was written in Ruby and uses the Colorize gem.

[colorize](https://github.com/fazibear/colorize)
