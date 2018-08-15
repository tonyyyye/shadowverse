use Log::Async;
use Enum;
use Entity;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

=para
Shadowverse::Entity::Player::Player_jobs::
What a Player can do.

role Player_jobs {
    =para
    Shadowverse::Entity::Player::load_deck::
    load decks for Player

    method load_deck {
        # TODO add more details
        return True;
    }
}


=para
Shadowverse::Entity::Player::
A robot or a human controls Player

class Player is Entity does Player_jobs {

    method BUILDALL(|) {
        @PODS.append: $=pod;
        callsame;
        $.id = $ENTITY_COUNT;
        self;
    }
}
