use Test;
use lib <lib>;
use Entity;
use Enum;
use Player;
use Card;
use Hero;


use-ok 'Player',
    '  UNIT_Player_TC_001          |class Player ';

ok my $palyer_u001 = Player.new(),
    '  UNIT_Player_TC_002          |create empty Player ';

is $palyer_u001.id, 1,
    '  UNIT_Player_TC_003          |Entity ID of a Player ';

my $palyer_u002 = Player.new();
is $palyer_u002.id, 2,
    '  UNIT_Player_TC_004          |Entity ID increases ';

my Card $card_u003;
my @deck_u003 = [ $card_u003, $card_u003 ];
ok my $player_u003 = Player.new(
          deck => @deck_u003,
      ),
    '  UNIT_Player_TC_005          |create Player with parameters ';

my @deck_u004 = @deck_u003;
my Hero $hero_u004 = Hero.new();
ok my $player_u004 = Player.new(
          deck => @deck_u004,
          hero => $hero_u004,
      ),
    '  UNIT_Player_TC_006          |create Player with Hero ';

$player_u004.load_deck("./doc/test.deck");










done-testing;
