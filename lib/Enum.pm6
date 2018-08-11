=para
Shadowverse::Enum::
List out global value for all modules

## scalars
our $IS_DEBUG = True;
=para
Shadowverse::Enum::ENTITY_COUNT::
List out Entity sequence as it is created .

our $ENTITY_COUNT;
our $ALL_CARDS_FILE = "./doc/cards.json";


## arrays
our @PODS;
our @ALL_CARDS_DATA;


## hashes
=para
Shadowverse::Enum::CODE_OF::
List out all default code

our %CODE_OF =
    UNDEFINED          =>  0,
    DEFAULT_INT        =>  0,
    DEFAULT_STR        =>  'SHADOWVERSE',
    DEFAULT_ARRAY      =>  ['SHADOWVERSE'],
    DEFAULT_HASH       =>  ('SHADOWVERSE' => 0),
;

=para
Shadowverse::Enum::TYPE_OF::
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
Shadowverse::Enum::CLASS_OF::
List out all class code

our %CLASS_OF =
    UNDEFINED          => 0,
    CHAOYUEZHE         => 1,
    LONGZU             => 2,
;
