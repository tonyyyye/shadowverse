use Log::Async;
use JSON::Fast;
use Enum;
use Entity;
use Player;
use Card;

logger.send-to('log/INFO_Game.log', :level(INFO));
logger.send-to('log/DEBUG_Game.log', :level(DEBUG));
logger.send-to('log/ERROR_Game.log', :level(ERROR));


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

    method init() {
        $.player1 = Player.new();
        $.player2 = Player.new();
        for ($!player1, $!player2) -> $player {
            $player.init();
            $player.Game = self;
        }
        $!player1.opponent_player = $!player2;
        $!player2.opponent_player = $!player1;
        ($!first_player, $!second_player) = self.roll_playing_sequence;
        # $!first_player.opponent_player = $!second_player;
        # $!second_player.opponent_player = $!first_player;

        # self.load_all_cards(); # use in real Game
        return self;
    }

    =para
    Shadowverse::Entity::Game::load_all_cards()::
    load all Card by its card_name

    method load_all_cards() {
        # modify the json file name
        @ALL_CARDS_DATA =
            from-json(slurp $ALL_CARDS_FILE){'data'}{'cards'}.clone;
        %DATA_OF_CARD = SHADOWVERSE => %BLANK_CARD;
        for @ALL_CARDS_DATA -> $hash_card {
            my $card_name = $hash_card{'card_name'};
            my Card $card_by_name = Card.new(
                clan                         => $hash_card{'clan'},
                skill                        => $hash_card{'skill'},
                cost                         => $hash_card{'cost'},
                life                         => $hash_card{'life'},
                base_card_id                 => $hash_card{'base_card_id'},
                org_skill_disc               => $hash_card{'org_skill_disc'},
                atk                          => $hash_card{'atk'},
                get_red_ether                => $hash_card{'get_red_ether'},
                normal_card_id               => $hash_card{'normal_card_id'},
                copyright                    => $hash_card{'copyright'},
                tokens                       => $hash_card{'tokens'},
                format_type                  => $hash_card{'format_type'},
                evo_description              => $hash_card{'evo_description'},
                card_set_id                  => $hash_card{'card_set_id'},
                card_name                    => $hash_card{'card_name'},
                char_type                    => $hash_card{'char_type'},
                skill_option                 => $hash_card{'skill_option'},
                rarity                       => $hash_card{'rarity'},
                foil_card_id                 => $hash_card{'foil_card_id'},
                evo_skill_disc               => $hash_card{'evo_skill_disc'},
                cv                           => $hash_card{'cv'},
                restricted_count             => $hash_card{'restricted_count'},
                card_id                      => $hash_card{'card_id'},
                tribe_name                   => $hash_card{'tribe_name'},
                org_evo_skill_disc           => $hash_card{'org_evo_skill_disc'},
                evo_life                     => $hash_card{'evo_life'},
                use_red_ether                => $hash_card{'use_red_ether'},
                is_foil                      => $hash_card{'is_foil'},
                skill_disc                   => $hash_card{'skill_disc'},
                evo_atk                      => $hash_card{'evo_atk'},
                description                  => $hash_card{'description'},
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
        return %DATA_OF_CARD{'SHADOWVERSE'};
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
            return ($!player1,$!player2);
        }
        else {
            debug " Player 2 wins ";
            $IS_PLAYER1_FIRST = False;
            return ($!player2,$!player1);
        }
    }
}

=para
Shadowverse::Entity::Game::Cheat_jobs::
Give Player privileges to do something

role Cheat_jobs {

}

=para
Shadowverse::Entity::Game::
A Game object is all a user needs.

class Game is Entity does Game_jobs does Cheat_jobs {
    method BUILDALL(|) {
        callsame;
        @PODS.append: $=pod;
        # Entity/Player ID reset to 0/1/2 when Game start
        $.id = $ENTITY_COUNT = 0;
        self;
    }
}
