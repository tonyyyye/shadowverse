use Test;
use lib <lib>;
use Game;


use-ok 'Game',
    'UNIT_Game_TC_000            |class Game ';

ok my $game_u001 = Game.new(),
    'UNIT_Game_TC_001            |empty Game ';

is $game_u001.id(), 1,
    'UNIT_Game_TC_002            |Entity ID ';

my $game_u002 = Game.new();
is $game_u002.id(), 1,
    'UNIT_Game_TC_003            |Entity ID restart ';

is $game_u002.find_card(900111020), True,
    'UNIT_Game_TC_004            |can find a existing card ';
is $game_u002.find_card(13579), False,
    'UNIT_Game_TC_005            |can alert a non-existing card ';







done-testing;
