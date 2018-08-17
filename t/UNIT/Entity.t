use Test;
use lib <lib>;
use Entity;
use Enum;


use-ok 'Entity',
    'UNIT_Entity_TC_001          |class Entity ';

ok my $entity_u001 = Entity.new(),
    'UNIT_Entity_TC_002          |empty Entity ';

is $entity_u001.id, 1,
    'UNIT_Entity_TC_003          |Entity ID ';

my $entity_u002 = Entity.new();
is $entity_u002.id, 2,
    'UNIT_Entity_TC_004          |Entity ID increases ';

my %expected_entity_u002 = (
    id           => 2,
    name         => 'SHADOWVERSE',
    type         => 1,
    'id()'       => 'IS_A_METHOD',
    'name()'     => 'IS_A_METHOD',
    'type()'     => 'IS_A_METHOD',
    'entity()'   => 'IS_A_METHOD',
    'help()'     => 'IS_A_METHOD',
    'BUILDALL()' => 'IS_A_METHOD',
   );
is $entity_u002.entity(),    %expected_entity_u002,
    'UNIT_Entity_TC_005          |use entity() to show structure ';

is $entity_u002.help('help()'), ' Show description of a method ' ~
    ':parameters: The method/instance name that you want to know ' ~
    ':return: A string form of the description .',
    'UNIT_Entity_TC_005          |use help()';

is $entity_u002.help('Entity'), ' Everything is an Entity .',
    'UNIT_Entity_TC_006          |use help(Class) ';

my $entity_u003 = Entity.new(
        :name<hero_test>,
        type => %TYPE_OF{'HERO'},
   );
my %expected_entity_u003 = (
    id           => 3,
    name         => 'hero_test',
    type         => 5,
    'id()'       => 'IS_A_METHOD',
    'name()'     => 'IS_A_METHOD',
    'type()'     => 'IS_A_METHOD',
    'entity()'   => 'IS_A_METHOD',
    'help()'     => 'IS_A_METHOD',
    'BUILDALL()' => 'IS_A_METHOD',
   );
is $entity_u003.entity, %expected_entity_u003,
    'UNIT_Entity_TC_007          |create Entity with arguments ';



















done-testing;
