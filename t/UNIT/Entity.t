use v6.c;
use Test;
use Log::Async;
use lib <lib>;
use Entity;

logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));



use-ok 'Entity',
    'UNIT_Entity_TC_000          |class Entity ';

ok my $entity_u001 = Entity.new(),
    'UNIT_Entity_TC_001          |empty Entity ';

is $entity_u001.entity_id, 1,
    'UNIT_Entity_TC_002          |Entity ID ';

my $entity_u002 = Entity.new();
is $entity_u002.entity_id, 2,
    'UNIT_Entity_TC_003          |Entity ID increases ';

is $entity_u002.entity(), "\$!entity_id.Str\t\t:2\n",
    'UNIT_Entity_TC_004          |use entity() to show structure ';

is $entity_u002.help('help'), ' Show description of a method ',
    'UNIT_Entity_TC_005          |use help()';































done-testing;
