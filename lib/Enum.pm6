use v6.c;


=para
SV::Enum::
List out global value for all modules

## scalar
our $IS_DEBUG = True;
our $entity_count;

## hash
=para
SV::Enum::CODE_OF::
List out all default code

our %CODE_OF =
    UNDEFINED          =>  0,
    DEFAULT_INT        =>  0,
    DEFAULT_STR        =>  'SHADOWVERSE',
    DEFAULT_ARRAY      =>  ['SHADOWVERSE'],
    DEFAULT_HASH       =>  ('SHADOWVERSE' => 0),
;


=para
SV::Enum::TYPE_OF::
List out all internal code

our %TYPE_OF =
    UNDEFINED          => 0,
    ENTITY             => 1,
    GAME               => 2,
    PLAYER             => 3,
    JUDGER             => 4,
    HERO               => 5,
    MINION             => 6,
    RUNE               => 7,
    SPELL              => 8,
    BUFF               => 9,
    CUSTOM             => 50,
    COLLECTION         => 100,
    # COLLECTION + MINION + HERO
    CREATURE           => 111,
    # COLLECTION + MINION + RUNE
    ONFIELD            => 113,
    # COLLECTION + MINION + RUNE + HERO
    CHARACHTER         => 118,
;


=para
SV::Enum::CLASS_OF::
List out all class code

our %CLASS_OF =
    UNDEFINED          => 0,
    CHAOYUEZHE         => 1,
    LONGZU             => 2,
;
