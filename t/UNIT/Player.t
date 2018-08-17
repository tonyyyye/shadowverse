use Test;
use lib <lib>;
use Entity;
use Enum;
use Player;
use Card;


use-ok 'Player',
    'UNIT_Player_TC_001          |class Player ';

ok my $palyer_u001 = Player.new(),
    'UNIT_Player_TC_002          |create empty Player ';

is $palyer_u001.id, 1,
    'UNIT_Player_TC_003          |Entity ID of a Player ';

my $palyer_u002 = Player.new();
is $palyer_u002.id, 2,
    'UNIT_Player_TC_004          |Entity ID increases ';

my Card $card_u003;
my @prepared_deck = [ $card_u003, $card_u003 ];
ok my $player_u003 = Player.new(
          deck => @prepared_deck,
          #hero => $hero_002,
      ),
    'UNIT_Player_TC_005          |create Player with parameters ';













done-testing;
