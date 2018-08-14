use Log::Async;
use Enum;
use Entity;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

=para
Shadowverse::Entity::Card::Card_jobs::
What a Card can do.

role Card_jobs {

}


=para
Shadowverse::Entity::Card::
Card consists deck for Player

class Card is Entity does Card_jobs {
    method BUILDALL(|) {
        @PODS.append: $=pod;
        callsame;
        $.id = $ENTITY_COUNT;
        self;
    }
}
