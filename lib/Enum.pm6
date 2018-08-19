use JSON::Fast;

=para
Shadowverse::Enum::
List out global value for all modules

## scalars
our $IS_DEBUG = True;
=para
Shadowverse::Enum::ENTITY_COUNT::
List out Entity sequence as it is created .

our $ENTITY_COUNT;

# reserve 100001 ~ 101000 as debug code
our $ENTITY_METHOD     = 100001;
our $ALL_CARDS_FILE    = "./doc/cards.json.short";

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

=para
Shadowverse::Enum::DATA_OF::
store all data of official cards in Hash

our %DATA_OF_TEMPLATE_CARD =
    clan               => %CODE_OF<DEFAULT_STR>,
    skill              => %CODE_OF<DEFAULT_STR>,
    cost               => %CODE_OF<DEFAULT_STR>,
    life               => %CODE_OF<DEFAULT_STR>,
    base_card_id       => %CODE_OF<DEFAULT_STR>,
    org_skill_disc     => %CODE_OF<DEFAULT_STR>,
    atk                => %CODE_OF<DEFAULT_STR>,
    get_red_ether      => %CODE_OF<DEFAULT_STR>,
    normal_card_id     => %CODE_OF<DEFAULT_STR>,
    copyright          => %CODE_OF<DEFAULT_STR>,
    tokens             => %CODE_OF<DEFAULT_STR>,
    format_type        => %CODE_OF<DEFAULT_STR>,
    evo_description    => %CODE_OF<DEFAULT_STR>,
    card_set_id        => %CODE_OF<DEFAULT_STR>,
    card_name          => %CODE_OF<DEFAULT_STR>,
    char_type          => %CODE_OF<DEFAULT_STR>,
    skill_option       => %CODE_OF<DEFAULT_STR>,
    rarity             => %CODE_OF<DEFAULT_STR>,
    foil_card_id       => %CODE_OF<DEFAULT_STR>,
    evo_skill_disc     => %CODE_OF<DEFAULT_STR>,
    cv                 => %CODE_OF<DEFAULT_STR>,
    restricted_count   => %CODE_OF<DEFAULT_STR>,
    card_id            => %CODE_OF<DEFAULT_STR>,
    tribe_name         => %CODE_OF<DEFAULT_STR>,
    org_evo_skill_disc => %CODE_OF<DEFAULT_STR>,
    evo_life           => %CODE_OF<DEFAULT_STR>,
    use_red_ether      => %CODE_OF<DEFAULT_STR>,
    is_foil            => %CODE_OF<DEFAULT_STR>,
    skill_disc         => %CODE_OF<DEFAULT_STR>,
    evo_atk            => %CODE_OF<DEFAULT_STR>,
    description        => %CODE_OF<DEFAULT_STR>,
;

our %DATA_OF_CARD =
    template_card      => %DATA_OF_TEMPLATE_CARD,
;
