use Test;
use lib <lib>;
use Entity;
use Enum;
use Game;
use Player;
use Hero;
use Card;


my ($card, $card1, $card2, $player, $hero, $expected_result);
use-ok 'Card',
    '  UNIT_Card_TC_001        |class Card ';

ok my $card_u001 = Card.new(),
    '  UNIT_Card_TC_002        |create empty Card ';

is $card_u001.id, 1,
    '  UNIT_Card_TC_003        |Entity ID of a Card ';

my $card_u002 = Card.new(card_name => 'SV_TEST');
is $card_u002.id, 2,
    '  UNIT_Card_TC_004        |Entity ID increases ';













done-testing;
