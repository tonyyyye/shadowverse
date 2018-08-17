use Test;
use Log::Async;
use Terminal::ANSIColor;
use lib <lib>;
use Game;
use Player;


logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

my $game_index = 10000000;
my ($player1,$player2);
sub case($text) {
    $game_index++;
    colored("ALL_TC_$game_index             |$text",
        'bold black on_white');
}


ok my $game_10000001 = Game.new(),
    case('an empty Game ');

$player1 = Player.new();
$player2 = Player.new();
ok my $game_10000002 = Game.new(
          Player1 => $player1,
          Player2 => $player2,
      ),
   case('Game with empty Player ');








done-testing;
