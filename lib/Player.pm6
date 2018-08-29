use Log::Async;
use Enum;
use Entity;
use Card;
use Hero;
logger.send-to('log/INFO_Player.log', :level(INFO));
logger.send-to('log/ERROR_Player.log', :level(ERROR));


=para
Shadowverse::Entity::Player::Player_jobs::
What a Player can do.

role Player_jobs {
    # TODO set opponent_player as Player
    has $.opponent_player is rw;
    has $.Game is rw;
    has Card @.deck is rw;
    has Card @.graveyard is rw;
    has Hero $.hero is rw;

    =para
    Shadowverse::Entity::Player::init():

    method init() {
        return self;
    }


    =para
    Shadowverse::Entity::Player::load_deck()::
    load deck for Player

    multi method load_deck(@deck_by_name) {
        for @deck_by_name {
            my $card_copy = %DATA_OF_CARD{$_}.clone;
            $card_copy.Player = self;
            @!deck.push($card_copy);
        }
        return self;
    }

    multi method load_deck($deck_file) {
        my ($deck,$data,$class);
        # TODO deck_check
        #
        if not $deck_file.IO.e {
            error "No such file. Use $DEFAULT_DECK instead ";
            $deck = $DEFAULT_DECK;
        }

        my @lines = $deck.IO.lines;

        # $data = slurp $deck;

        # for @deck_by_name {
        #     my $card_copy = %DATA_OF_CARD{$_}.clone;
        #     $card_copy.Player = self;
        #     @!deck.push($card_copy);
        # }
        return self;
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
