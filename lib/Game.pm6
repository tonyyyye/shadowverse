use Log::Async;
use Enum;
use Entity;
use Player;
use Card;


logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

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

    method init {
        return self;
    }

    =para
    Shadowverse::Entity::Game::load_all_cards()::
    load all Card by its card_id

    method load_all_cards {
        for @ALL_CARDS_DATA -> $hash_card {
            my $card_name = $hash_card{'card_name'};
            # TODO push Card instead of Hash
            %DATA_OF_CARD{$card_name} = $hash_card;
        }
        return True;
        # @ALL_CARDS_DATA.say;
        # return True;
    }


    =para
    Shadowverse::Entity::Game::check_card()::
    find a card by its card_id

    method check_card($card_id) {
        for @ALL_CARDS_DATA -> $card_data {
            if $card_data{'card_id'} eq $card_id {
                # info("The card with id: $card_id is found");
                return True;
            }
        }
        error("The card with id:  $card_id does not exist ");
        return False;
    }

    =para
    Shadowverse::Entity::Game::players()::
    return all Player

    method players() {
        return ($!player1, $!player2);
    }

    =para
    Shadowverse::Entity::Game::players()::
    return all Player in revert sequence

    method switch_players() {
        return ($!player2, $!player1);
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
