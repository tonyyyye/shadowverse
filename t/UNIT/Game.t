use Test;
use lib <lib>;
use Game;


use-ok 'Game',
    'UNIT_Game_TC_000            |class Game ';

ok my $game_u001 = Game.new(),
    'UNIT_Game_TC_001            |empty Game ';

is $game_u001.id(), 1,
    'UNIT_Game_TC_002            |Entity ID ';











done-testing;
