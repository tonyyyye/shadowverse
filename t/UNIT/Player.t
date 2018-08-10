use Test;
use lib <lib>;
use Entity;
use Enum;
use Player;


use-ok 'Player',
    'UNIT_Player_TC_000          |class Player ';

ok my $palyer_u001 = Player.new(),
    'UNIT_Player_TC_001          |empty Player ';

is $palyer_u001.id, 1,
    'UNIT_Player_TC_002          |Entity ID of a Player ';

my $palyer_u002 = Player.new();
is $palyer_u002.id, 2,
    'UNIT_Player_TC_003          |Entity ID increases ';
















done-testing;
