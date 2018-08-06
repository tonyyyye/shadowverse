use Test;
use lib <lib>;
use Entity;


use-ok 'Entity',
    'UNIT_Entity_TC_000          |class Entity ';

ok my $entity_u001 = Entity.new(),
    'UNIT_Entity_TC_001          |empty Entity ';

is $entity_u001.id, 1,
    'UNIT_Entity_TC_002          |Entity ID ';

my $entity_u002 = Entity.new();
is $entity_u002.id, 2,
    'UNIT_Entity_TC_003          |Entity ID increases ';

my %expected_entity_u002 = (
    'id'        => 2,
    'name'      => 'SV',
    'type'      => 1,
);
is $entity_u002.entity(),    %expected_entity_u002,
    'UNIT_Entity_TC_004          |use entity() to show structure ';

is $entity_u002.help('help'), ' Show description of a method ' ~
    ':parameters: The method/instance that you want to know ' ~
    ':return: A string form of its own .',
    'UNIT_Entity_TC_005          |use help()';































done-testing;
