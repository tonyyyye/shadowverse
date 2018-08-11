use Test;
use Log::Async;
use Terminal::ANSIColor;
use lib <lib>;
use Game;
use Player;


logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

my $game_index = 10000000;
sub re($text) {
    $game_index++;
    colored("ALL_TC_$game_index             |$text",
        'bold white on_green');
}


ok my $game_10000000 = Game.new(),
    colored("ALL_TC_$game_index             |an empty Game ",
        'bold white on_green');

my $player1 = Player.new();
my $player2 = Player.new();
ok my $game_u002 = Game.new(
       Player1 => $player1,
       Player2 => $player2,
      ),
   re('Game with empty Player ');








done-testing;
