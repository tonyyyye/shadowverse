use Log::Async;
use Enum;
use Entity;
use Card;
use Hero;

logger.send-to('log/INFO_Player.log', :level(INFO));
logger.send-to('log/ERROR_Player.log', :level(ERROR));
logger.send-to('log/DEBUG_Player.log', :level(DEBUG));


=para
Shadowverse::Entity::Player::Player_jobs::
What a Player can do.

role Player_jobs {
    has Int $.class is rw;
    has Int $.max_field_length is default(5);
    has Int $.slot_ramained is default(5);

    # TODO Game.init() makes opponent_player as Player
    has $.opponent_player is rw;

    has $.Game is rw;
    has Card @.deck is rw;
    has Card @.field is rw;
    has Card @.graveyard is rw;
    has Hero $.hero is rw;
    has Str $.deck_name is rw;


    =para
    Shadowverse::Entity::Player::init()::

    method init() {
        # TODO Player needs
        # deck Card/Hero
        # operations/special power
        return self;
    }

    =para
    Shadowverse::Entity::Player::can()::
    all available operations Player can choose from

    method can(){
        my @available_operations;
        # TODO operations include EXCEPT concede
        # can/emoji/card.play()/evolve minion
        # check attributes/let minion attack/end turn
        return @available_operations;
    }

    =para
    Shadowverse::Entity::Player::load_deck()::
    load deck for Player

    method load_deck(Str:D $given_deck_file) {
        my ($deck_file, $data, $class, $card_count, $card_name);
        my (@cards_by_name, @deck_lines);
        my $test_deck_file = "./doc/deck/$given_deck_file";
        # TODO check if deck is illegal
        if not $test_deck_file.IO.e {
            error "No such file. Use $DEFAULT_DECK instead ";
            $deck_file = $DEFAULT_DECK;
        }
        else {
            $deck_file = $test_deck_file;
        }

        @deck_lines = $deck_file.IO.lines;
        $!deck_name = @deck_lines.shift;
        $!class = @deck_lines.shift.Int;
        for @deck_lines {
            if m/^\d/ {
                ($card_count, $card_name) = split( /\*/, $_ );
                for ^$card_count {
                    # @cards_by_name.push($card_name);
                    my $card_copy = %DATA_OF_CARD{$card_name}.clone;
                    $card_copy.Player = self;
                    @!deck.push($card_copy);
                }
            }

        }

        # for @cards_by_name {
        #     my $card_copy = %DATA_OF_CARD{$_}.clone;
        #     $card_copy.Player = self;
        #     @!deck.push($card_copy);
        # }
        return self;
    }

    =para
    Shadowverse::Entity::Player::end_turn()::

    method end_turn() {
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
