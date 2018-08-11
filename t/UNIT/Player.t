use Test;
use lib <lib>;
use Entity;
use Enum;
use Player;


use-ok 'Player',
    'UNIT_Player_TC_000          |class Player ';

ok my $palyer_u001 = Player.new(),
    'UNIT_Player_TC_001          |create empty Player ';

is $palyer_u001.id, 1,
    'UNIT_Player_TC_002          |Entity ID of a Player ';

my $palyer_u002 = Player.new();
is $palyer_u002.id, 2,
    'UNIT_Player_TC_003          |Entity ID increases ';


my @prepared_deck = [ 'WISP', 'WISP', 'WISP',  ];
ok my $player_u003 = Player.new(
        deck => @prepared_deck,
        hand => @prepared_deck.pick: 2,
        name => 'yey',
        #hero => $hero_002,
      ),
    'UNIT_Player_TC_004          |create Player with parameters ';













done-testing;
