use Log::Async;
use Enum;
use Entity;
use Player;
use Card;
logger.send-to('log/ERROR_Game.log', :level(ERROR));


=para
Shadowverse::Entity::Game::Game_jobs::
What a Game can do.

role Game_jobs {
    has Int $.type is default(%TYPE_OF{'GAME'});
    has Player $.player1 is rw;
    has Player $.player2 is rw;
    has Player @.players is rw;
    has Card @.set_aside is rw;

    =para
    Shadowverse::Entity::Games::init():
    Initialize a game this includes several steps:
    1 Load Player, Hero, Deck
    2 Choose which to play first
    TODO (3 Return a protobuff)
    :param:  TODO None
    :return: A structured form of its all attributes

    method init() {
        return self;
    }

    =para
    Shadowverse::Entity::Game::load_all_cards()::
    load all Card by its card_id

    method load_all_cards(--> Hash:D) {
        for @ALL_CARDS_DATA -> $hash_card {
            my $card_name = $hash_card{'card_name'};
            # TODO push Card instead of Hash
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
        return %DATA_OF_CARD;
    }


    =para
    Shadowverse::Entity::Game::check_card()::
    find a card by its card_name

    method check_card(Str:D $card_name --> Card:D) {
        if %DATA_OF_CARD{$card_name}.exist {
                # info("The card with id: $card_id is found");
                return %DATA_OF_CARD{$card_name};
        }
        error("The card with card_name : $card_name does not exist ");
        return False;
    }

    =para
    Shadowverse::Entity::Game::players()::
    list two Player in normal sequence

    method players() {
        return ($!player1, $!player2);
    }

    =para
    Shadowverse::Entity::Game::switch_players()::
    list two Player in revert sequence

    method switch_players() {
        return ($!player2, $!player1);
    }

    =para
    Shadowverse::Entity::Game::roll()::
    roll playing sequence of Player

    method roll() {
        if (False, True).roll {
            return self.players();
        }
        else {
            return self.switch_players();
        }
    }
}

=para
Shadowverse::Entity::Game::Cheat_jobs::
Give privileges to do something

role Cheat_jobs {

}

=para
Shadowverse::Entity::Game::
A Game object is all a user needs.

class Game is Entity does Game_jobs does Cheat_jobs {
    method BUILDALL(|) {
        callsame;
        @PODS.append: $=pod;
        # Reset to 1 when game start
        $.id = $ENTITY_COUNT = 1;
        self;
    }
}
