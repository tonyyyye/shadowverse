use Log::Async;
use JSON::Fast;
use Enum;
use Entity;
use Player;
use Hero;
use Card;

# INFO for Game.xml
logger.send-to("$LOG_DIR/INFO_Game.log", :level(INFO));
logger.send-to("$LOG_DIR/DEBUG_Game.log", :level(DEBUG));
logger.send-to("$LOG_DIR/ERROR_Game.log", :level(ERROR));

=para
Shadowverse::Entity::Game::Game_jobs::
What a Game can do.

role Game_jobs {
    has Int $.type is default(%TYPE_OF{'GAME'});
    has Player $.player1 is rw;
    has Player $.player2 is rw;
    has Player $.first_player is rw;
    has Player $.second_player is rw;
    has Player $.current_player is rw;

    =para
    Shadowverse::Entity::Games::init():
    Initialize a game this includes several steps:
    1 Load Player, Hero, Deck
    2 Choose which to play first
    TODO (3 Return a protobuff)
    :param:  TODO None
    :return: A structured form of its all attributes

    multi method init() {
        $.player1 = Player.new();
        $.player2 = Player.new();
        for ($!player1, $!player2) -> $player {
            $player.init();
            $player.Hero = Hero.new.init();
            $player.Game = self;
        }
        $!player1.opponent_player = $!player2;
        $!player2.opponent_player = $!player1;
        ($!first_player, $!second_player) = self.roll_playing_sequence;
        $!first_player.opponent_player = $!second_player;
        $!second_player.opponent_player = $!first_player;
        self.load_all_cards();
        # FIXME ENTITY_COUNT bug
        # $ENTITY_COUNT.say;
        # self.current_player.id.say;
        return self;
    }
    multi method init($deck_of_player1,$deck_of_player2) {
        $!player1 = Player.new();
        $!player1.init($deck_of_player1);
        $!player2 = Player.new();
        $!player2.init($deck_of_player2);
        $!player1.Game = $!player2.Game = self;
        $!player1.opponent_player = $!player2;
        $!player2.opponent_player = $!player1;
        ($!first_player, $!second_player) = self.roll_playing_sequence;
        $!first_player.opponent_player = $!second_player;
        $!second_player.opponent_player = $!first_player;
        self.load_all_cards();
        return self;
     }

    =para
    Shadowverse::Entity::Game::load_all_cards()::
    load all Card by its card_name

    method load_all_cards() {
        # modify the json file name
        @ALL_CARDS_DATA =
            from-json(slurp $ALL_CARDS_FILE){'data'}{'cards'}.clone;
            my Card $card_by_name = Card.new(
        card_name => %CODE_OF{'DEFAULT_STR'},
        card_id   => %CODE_OF{'DEFAULT_CARD_ID'},
        );
    # blank Card for test
    %DATA_OF_CARD = SHADOWVERSE => $card_by_name;
    for @ALL_CARDS_DATA -> $attribute_of {
        my $card_name = $attribute_of{'card_name'};
        $card_by_name = Card.new(
            clan                         => $attribute_of{'clan'},
            skill                        => $attribute_of{'skill'},
            cost                         => $attribute_of{'cost'},
            life                         => $attribute_of{'life'},
            base_card_id                 => $attribute_of{'base_card_id'},
            org_skill_disc               => $attribute_of{'org_skill_disc'},
            atk                          => $attribute_of{'atk'},
            get_red_ether                => $attribute_of{'get_red_ether'},
            normal_card_id               => $attribute_of{'normal_card_id'},
            copyright                    => $attribute_of{'copyright'},
            tokens                       => $attribute_of{'tokens'},
            format_type                  => $attribute_of{'format_type'},
            evo_description              => $attribute_of{'evo_description'},
            card_set_id                  => $attribute_of{'card_set_id'},
            card_name                    => $attribute_of{'card_name'},
            char_type                    => $attribute_of{'char_type'},
            skill_option                 => $attribute_of{'skill_option'},
            rarity                       => $attribute_of{'rarity'},
            foil_card_id                 => $attribute_of{'foil_card_id'},
            evo_skill_disc               => $attribute_of{'evo_skill_disc'},
            cv                           => $attribute_of{'cv'},
            restricted_count             => $attribute_of{'restricted_count'},
            card_id                      => $attribute_of{'card_id'},
            tribe_name                   => $attribute_of{'tribe_name'},
            org_evo_skill_disc           => $attribute_of{'org_evo_skill_disc'},
            evo_life                     => $attribute_of{'evo_life'},
            use_red_ether                => $attribute_of{'use_red_ether'},
            is_foil                      => $attribute_of{'is_foil'},
            skill_disc                   => $attribute_of{'skill_disc'},
            evo_atk                      => $attribute_of{'evo_atk'},
            description                  => $attribute_of{'description'},

        );
            %DATA_OF_CARD{$card_name} = $card_by_name;
        }
        # get self by default
        return self;
    }

    =para
    Shadowverse::Entity::Game::check_card()::
    find a card by its card_name

    method check_card(Str:D $card_name) {
        if %DATA_OF_CARD{$card_name}.defined {
                debug "The card with name: $card_name is found";
                return %DATA_OF_CARD{$card_name};
        }

        error "card_name $card_name does not exist ";
        return %BLANK_CARD;
    }

    =para
    Shadowverse::Entity::Game::players()::
    list two Player in normal sequence

    method players() {
        return ($!current_player, $!current_player.opponent_player);
    }

    =para
    Shadowverse::Entity::Game::roll_first()::
    roll playing sequence of Player

    method roll_playing_sequence() {
        if ( True, False ).pick {
            debug " Player 1 wins ";
            $!current_player = $!player1;
            return ($!player1,$!player2);
        }
        else {
            debug " Player 2 wins ";
            $IS_PLAYER1_FIRST = False;
            $!current_player = $!player2;
            return ($!player2,$!player1);
        }
    }
}


=para
Shadowverse::Entity::Game::
A Game object is all a user needs.

class Game is Entity does Game_jobs {
    method BUILDALL(|) {
        callsame;
        @PODS.append: $=pod;
        # Entity/Player ID reset to 0/1/2 when Game start
        $.id = $ENTITY_COUNT = 0;
        self;
    }
}
