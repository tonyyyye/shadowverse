use Test;
use Log::Async;
use Terminal::ANSIColor;
use lib <lib>;
use Game;
use Player;
use Card;


logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

my $game_index = 10000000;
my ($player1,$player2);
my (@deck1 ,@deck2);

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


for ^40 {
    @deck1[$_]= Card.new;
    @deck2[$_]= Card.new;
};
$player1 = Player.new(deck => @deck1);
$player2 = Player.new(deck => @deck2);

ok my $game_10000003 = Game.new(
          Player1 => $player1,
          Player2 => $player2,
      ),
   case('Game with Player and Card ');



done-testing;
