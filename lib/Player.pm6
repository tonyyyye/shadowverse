use Enum;
use Entity;
use Card;


=para
Shadowverse::Entity::Player::Player_jobs::
What a Player can do.

role Player_jobs {
    # TODO set opponent_player as Player
    has $.opponent_player is rw;
    has Card @.deck is rw;
    has $.Game is rw;

    =para
    Shadowverse::Entity::Player::load_deck()::
    load deck for Player

    method load_deck(@deck_by_name) {
        for @deck_by_name {
            my $card_copy = %DATA_OF_CARD{$_}.clone;
            $card_copy.Player = self;
            @!deck.push($card_copy);
        }
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
