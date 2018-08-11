use JSON::Fast;
use Log::Async;
use Enum;
use Entity;
use Player;


logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

=para
Shadowverse::Entity::Game::Game_jobs::
What a Game can do.

role Game_jobs {
    has Int $.type is default(%TYPE_OF{'GAME'});
    has Player $.player1 is rw;
    has Player $.player2 is rw;
    has $.winner is rw;

    =para
    Shadowverse::Entity::Games::init:
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
    Shadowverse::Entity::Game::load_deck::
    Load all cards for cases.
    TODO built it in to speed up

    method load_all_cards {
    my $contents = slurp $ALL_CARDS_FILE;
        @ALL_CARDS_DATA = from-json($contents){'data'}{'cards'}.clone;
        return True;
    }

    =para
    Shadowverse::Entity::Game::find_card::
    find a card by its card_id

    method find_card($card_id) {
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
    Shadowverse::Entity::Game::players::
    return all Player

    method players() {
        return True;
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

class Game is Entity does Game_jobs {
    method BUILDALL(|) {
        callsame;
        @PODS.append: $=pod;
        # Reset to 1 when game start
        $.id = $ENTITY_COUNT = 1;
        self;
    }
}
