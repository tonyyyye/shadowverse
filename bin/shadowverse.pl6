use v6.c;
use Log::Async;
use Terminal::ANSIColor;
use JSON::Fast;
use lib <lib>;
use Enum;
use Entity;
use Hero;
use Game;
use Player;
use Card;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

say "Welcome to shadowverse";

my $game_player1 = Player.new();
my $game_player2 = Player.new();

my $game = Game.new(
       player1 => $game_player1,
       player2 => $game_player2,
);
# choose deck
# display field and Hero
# minion action:attack
# Player action:play Card
