<<<<<<< HEAD
use Enum;
use Entity;


=para
Shadowverse::Game::Game_jobs::
What a Game can do.

role Game_jobs {

    # has Player $.player1 is rw;
    # has Player $.player2 is rw;
    # has $.winner is rw;

    =para
    SV::Entity::Game::Game_jobs::init()::
    Initialize a game this includes several steps:
    1 Load Player, Hero, Deck
    2 Choose which to play first
    TODO (3 Return a protobuff)
    :param:  TODO None
    :return: A structured form of its all attributes

    method init() {
        return self;
    }

}

=para
Shadowverse::Game::Cheat_jobs::
give privileges to do jobs

role Cheat_jobs {

}

=para
Shadowverse::Game::
A Game object is all a user needs.

class Game is Entity does Game_jobs {
    has Int $.type is default(%TYPE_OF{'GAME'});
    method BUILDALL(|) {# initial things here
        callsame;   # call the parent classes (or default) BUILDALL
        @PODS.append: $=pod;
        $.id = $entity_count;
        self; # return the fully built object
    }
}
=======
use v6.c;
use Log::Async;
use Entity;
use Enum;


=para
Shadowverse::Game::Game_jobs::
What a Game can do.

role Game_jobs {
    has $.type = %TYPE_OF{'GAME'};
    # has Player $.player1 is rw;
    # has Player $.player2 is rw;
    # has $.winner is rw;

    =para
    SV::Entity::Game::Game_jobs::init()::
    Initialize a game this includes several steps:
    1 Load Player, Hero, Deck
    2 Choose which to play first
    TODO (3 Return a protobuff)
    :param:  TODO None
    :return: A structured form of its all attributes

    method init() {
        return self;
    }
}

=para
Shadowverse::Game::Cheat_jobs::
give privileges to do jobs

role Cheat_jobs {

}

=para
Shadowverse::Game::
A Game object is all a user needs.

class Game is Entity does Game_jobs {
    method BUILDALL(|) {# initial things here
        callsame;   # call the parent classes (or default) BUILDALL
        $.entity_id = $entity_count;
        self; # return the fully built object
    }
}
>>>>>>> c2f61002a889737beb5197750483e4d47a2b0d31
