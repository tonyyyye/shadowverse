use Test;
use lib <lib>;
use Entity;
use Enum;
use Game;
use Player;
use Card;
use Hero;

my ($card, $player, $hero, $game, $expected_result);
## basic tests
use-ok 'Player',
    '  UNIT_Player_TC_001     |class Player ';

ok my $player_u001 = Player.new(),
    '  UNIT_Player_TC_002     |create empty Player ';

is $player_u001.id, 1,
    '  UNIT_Player_TC_003     |Entity ID of a Player ';

my $player_u002 = Player.new();
is $player_u002.id, 2,
    '  UNIT_Player_TC_004     |Entity ID increases ';

## advanced tests
my @deck_u003 = [ Card.new(), Card.new() ];
ok my $player_u003 = Player.new(
          deck => @deck_u003,
      ),
    '  UNIT_Player_TC_005     |create Player with parameters ';

my @deck_u004 = @deck_u003;
my Hero $hero_u004 = Hero.new();
ok my $player_u004 = Player.new(
          deck => @deck_u004,
          hero => $hero_u004,
      ),
    '  UNIT_Player_TC_006     |create Player with Hero ';

## In real Game tests
$game = Game.new.init();
ok $game.player1.load_deck('more_cards.deck'),
    '  UNIT_Player_TC_007     |Player can init with deck ';

$player = $game.player1;
ok $player.load_deck('minions_of_one_kind.deck'),
    '  UNIT_Player_TC_008     |Player can load deck ';

ok $player.draw.play($game.player1.hand[0]).
           draw.play($game.player1.hand[0]),
    '  UNIT_Player_TC_009     |chain play ';
$player.draw.draw.play($game.player1.hand[0]);

# TODO summon Card
# FIXME card id






done-testing;
