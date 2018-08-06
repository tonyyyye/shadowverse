use Test;
use lib <lib>;
use Game;


use-ok 'Game',
    'UNIT_Game_TC_000            |class Game ';

ok my $game_u001 = Game.new(),
    'UNIT_Game_TC_001            |empty Game ';

<<<<<<< HEAD
is $game_u001.id(), 1,
=======
is $game_u001.entity_id(), 1,
>>>>>>> c2f61002a889737beb5197750483e4d47a2b0d31
    'UNIT_Game_TC_002            |Entity ID ';











done-testing;
