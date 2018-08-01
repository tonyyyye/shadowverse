use v6.c;
use Test;
use Log::Async;
use lib <lib>;
use Entity;
use Game;

use-ok 'Game',
    'UNIT_Game_TC_000            |class Game ';
ok my $game_u001 = Game.new(),
    'UNIT_Game_TC_001            |empty Game ';
done-testing;
