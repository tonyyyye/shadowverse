use Log::Async;
use Enum;
use Entity;
use Card;

logger.send-to("$LOG_DIR/INFO_Hero.log", :level(INFO));
logger.send-to("$LOG_DIR/DEBUG_Hero.log", :level(DEBUG));
logger.send-to("$LOG_DIR/ERROR_Hero.log", :level(ERROR));

=para
Shadowverse::Entity::Hero::Hero_jobs::
What a Hero can do.

role Hero_jobs {
    has $.life is default($MAX_HERO_LIFE) is rw;

    =para
    Shadowverse::Entity::Hero::attack()::
    Hero attack action

    method attack($target) {
        error 'Hero cannot do anything including attack ';
        return self;
    }

    =para
    Shadowverse::Entity::Hero::init()::
    initialize Hero

    method init() {
        return self;
    }

}


=para
Shadowverse::Entity::Hero::
An Entity that exists until Game ends

class Hero is Entity does Hero_jobs {
    method BUILDALL(|) {
        @PODS.append: $=pod;
        callsame;
        $.id = $ENTITY_COUNT;
        self;
    }
}
