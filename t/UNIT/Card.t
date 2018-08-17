use Test;
use lib <lib>;
use Entity;
use Enum;
use Card;


use-ok 'Card',
    'UNIT_Card_TC_001            |class Card ';

ok my $card_u001 = Card.new(),
    'UNIT_Card_TC_002            |create empty Card ';

is $card_u001.id, 1,
    'UNIT_Card_TC_003            |Entity ID of a Card ';

my $card_u002 = Card.new();
is $card_u002.id, 2,
    'UNIT_Card_TC_004            |Entity ID increases ';















done-testing;
