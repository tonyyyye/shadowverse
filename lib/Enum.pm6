use JSON::Fast;

=para
Shadowverse::Enum::
List out global value for all modules

## scalars
our $IS_DEBUG          = True;
our $IS_PLAYER1_FIRST  = True;
our $CURRENT_PLAYER_ID = 1;
our $MAX_HERO_LIFE     = 40;

=para
Shadowverse::Enum::ENTITY_COUNT::
List out Entity sequence as it is created
Especially, Game has ENTITY_COUNT 0 and Player 1/2 has 1/2

our $ENTITY_COUNT;

# reserve 10000001 ~ 10001000 as debug code
our $ENTITY_METHOD     = 10000001;
our $DEFAULT_DECK      = "./doc/deck/test.deck";
our $ALL_CARDS_FILE    = './doc/cards.json';
our $LOG_DIR           = './log';

## arrays
our @PODS;

=para
Shadowverse::Enum::ALL_CARDS_DATA::
List out all cards data from json file
TODO built it in to speed up

our @ALL_CARDS_DATA =
    from-json(slurp $ALL_CARDS_FILE){'data'}{'cards'}.clone;


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
    DEFAULT_CARD_ID    =>  10003001,
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
    CARD               => 10,
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
    # TODO check number is correct
    UNDEFINED          => 0,
    CHAOYUEZHE         => 1,
    LONGZU             => 2,
    JINGLING           => 3,
;

=para
Shadowverse::Enum::BLANK_CARD::
a blank Card indicates error or default

our %BLANK_CARD =
    BLANK              => 0,
;

=para
Shadowverse::Enum::DATA_OF_CARD::
list out all data in Card form

our %DATA_OF_CARD;

=para
Shadowverse::Enum::CODE_OF_OPERATION::
list out common operation code of Player

our %CODE_OF_OPERATION =
    CONCEDE            => 10002001,
    END_TURN           => 10002001,
    CARD_PLAY          => 10002003,
    MINION_CTRL        => 10002004,
    CONCEDE            => 10002886,
;

=para
Shadowverse::Enum::CODE_OF_ZONE::
List out all default code

our %CODE_OF_ZONE =
    DECK               => 1,
    HAND               => 2,
    FIELD              => 3,
    GRAVEYARD          => 4,
    DISCARD            => 5,
    HERO               => 6,
    INFINITY           => 99,
;
