use Test;
use lib <lib>;
use Entity;
use Enum;
use Game;
use Player;
use Hero;
use Card;

my ($card, $card1, $card2, $player, $hero, $expected_result);
## basic tests
use-ok 'Card',
    '  UNIT_Card_TC_001       |class Card ';

ok my $card_u001 = Card.new(),
    '  UNIT_Card_TC_002       |create empty Card ';

is $card_u001.id, 1,
    '  UNIT_Card_TC_003       |Entity ID of a Card ';

my $card_u002 = Card.new(card_name => 'SV_TEST');
is $card_u002.id, 2,
    '  UNIT_Card_TC_004       |Entity ID increases ';

## advanced tests
my $game_u001 = Game.new.init(); #load_all_cards
my $card_u003 = Card.new('Blessings of Creation');
is $card_u003.card_id, 900144020,
    '  UNIT_Card_TC_005       |create Card with name ';

## In real Game tests
$game_u001.player1.load_deck('minions_only.deck');
$expected_result = $game_u001.player1.deck[*-1];
is $expected_result.zone, %CODE_OF_ZONE{'DECK'},
    '  UNIT_Card_TC_006       |Card in deck ';

$game_u001.player1.draw;
$card = $game_u001.player1.hand[0];
is $card.zone, %CODE_OF_ZONE{'HAND'},
    '  UNIT_Card_TC_007       |When Player draw Card, zone changes ';

is $card, $expected_result,
    '  UNIT_Card_TC_008       |Card itself remains the same ';

ok $game_u001.player1.hand[*-1].be_played(),
    '  UNIT_Card_TC_009       |play without target ';

is $card.zone, %CODE_OF_ZONE{'FIELD'},
    ' UNIT_Card_TC_010       |when played, Card zone changes ';

$game_u001.player2.load_deck('minions_only.deck');
$card1 = $game_u001.player2.draw.hand[*-1].be_played();
$card2 = $game_u001.player2.draw.hand[*-1].be_played();
ok $card1.attack($card2),
    ' UNIT_Card_TC_011       |Card attack Card ';
ok $card2.attack($game_u001.player2.Hero),
    ' UNIT_Card_TC_012       |Card attack Hero ';
#
# $card = Card.new('Wood of Brambles');
# $card.entity.say;












done-testing;
