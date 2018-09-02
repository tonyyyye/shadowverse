use Test;
use lib <lib>;
use Entity;
use Enum;
use Hero;
use Card;

use-ok 'Hero',
    '  UNIT_Hero_TC_001            |class Hero ';

ok my $hero_u001 = Hero.new(),
    '  UNIT_Hero_TC_002            |create empty Hero ';

is $hero_u001.id, 1,
    '  UNIT_Hero_TC_003            |Entity ID of a Hero ';

my $hero_u002 = Hero.new(card_name => 'chaoyuezhe');
is $hero_u002.id, 2,
    '  UNIT_Hero_TC_004            |Entity ID increases ';

# ok $hero_u002.play();














done-testing;
