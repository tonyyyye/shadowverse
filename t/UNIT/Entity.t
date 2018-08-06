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

<<<<<<< HEAD
my %expected_entity_u002 = (
    'id'        => 2,
    'name'      => 'SV',
    'type'      => 1,
);
is $entity_u002.entity(),    %expected_entity_u002,
=======
is $entity_u002.entity(),
    "\$!entity_id.Str\t\t:2\n\$!name.Str\t\t:SV\n\$!type.Str\t\t:1\n",
>>>>>>> c2f61002a889737beb5197750483e4d47a2b0d31
    'UNIT_Entity_TC_004          |use entity() to show structure ';

is $entity_u002.help('help'), ' Show description of a method ' ~
    ':parameters: The method/instance that you want to know ' ~
    ':return: A string form of its own .',
    'UNIT_Entity_TC_005          |use help()';































done-testing;
