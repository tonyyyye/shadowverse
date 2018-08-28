use Log::Async;
use Enum;
use Entity;
use Card;

logger.send-to('log/INFO_Hero.log', :level(INFO));
logger.send-to('log/ERROR_Hero.log', :level(ERROR));


=para
Shadowverse::Entity::Hero::Hero_jobs::
What a Hero can do.

role Hero_jobs {
    method attack {
        error('Hero cannot do anything including attack ');
        return self;
    }
}


=para
Shadowverse::Entity::Hero::
An Entity that exists until Game ends

class Hero is Card is Entity does Hero_jobs {
    method BUILDALL(|) {
        @PODS.append: $=pod;
        callsame;
        $.id = $ENTITY_COUNT;
        self;
    }
}