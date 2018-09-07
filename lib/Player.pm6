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
    ## Player attributes
    has $.Game is rw;
    # TODO Game.init() makes opponent_player as Player
    has $.opponent_player is rw;
    has $.Hero is rw;
    has Card @.deck is rw;
    has Card @.field is rw;
    has Card @.graveyard is rw;
    has Int $.class is rw;
    has Str $!deck_name;
    has Bool %.executability_of is rw;
    has Int $.max_field_length is default(5);
    has Bool @.is_slot_occupied is default( False xx  5);
    has Str @!unavailable_methods;
    # indicates which operations that Player cannot choose
    has Str @.seal_methods is rw;
    has Int $!zone = 1; # TODO add Enum and add to Card
    # TODO add 'rush' for evolve
    has Bool $.is_able_to_evolve is default(False) is rw;
    has Int $.evolve_chance is default(3) is rw; # TODO add 1 to P.2nd
    has Bool %.activity_of_special_power is rw;
    has Int $.turn_count is rw;

    ## methods that Player run when initialize

    =para
    Shadowverse::Entity::Player::init()::
    Initialize Player when Game starts

    multi method init() {
        return self;
    }
    multi method init($deck_file) {
        self.load_deck($deck_file);
        self.init_hero($!class);
        self.init_special_power($!class);
        return self;
    }

    =para
    Shadowverse::Entity::Player::init_hero()::
    Initialize Hero when the deck is loaded

    method init_hero($class) {
        # TODO Hero should have life
        # $.Hero = Hero.new(class=$class);
        return True;
    }

    =para
    Shadowverse::Entity::Player::init_special_power()::
    Initialize special power for different $.class

    method init_special_power($class) {
        # TODO Hero special_power
        # 8 powers with 8 counters
        return True;
    }

    =para
    Shadowverse::Entity::Player::evolve()::
    change atk/life/effect and trigger everything else

    method evolve($minion) {
        if $.is_able_to_evolve {
            debug "able to evolve "
        }
        else {
            error "Haven't prepared to be evolved ";
        }
        if $.evolve_chance {
            # add current life to Card
            return True;
        }
        else {
            error "Sorry, no evolve points ramained ";
            return False;
        }
        return self;
    }

    =para
    Shadowverse::Entity::Player::let_minion()::
    Player can evolve a minion or control it to attack enermy

    method let_minion(:$minion_id, :$action, :$target_id?) {
        return self;
    }

    =para
    Shadowverse::Entity::Player::can()::
    all available operations Player can choose from

    method can( --> Array:D) {
        for self.^methods() -> $available_operation {
            my $operation = $available_operation.candidates.perl;
            my @parts = $operation.split(' ');
            # if it is NOT unavailable, then it is executable
            %.executability_of{@parts[1]} =
                $operation ~~ m/
                    BUILD                |Game           |BUILD|
                    executability_of     |type           |deck|
                    max_field_length     |init           |load_deck|
                    shuffle_deck         |seal_methods   |concede
                    unavailable_methods  |name
                    /.not.Bool;
        }
        my @available_operations;
        # TODO operations include EXCEPT concede
        # card.play()/evolve minion
        # check attributes/let minion attack/end turn
        for %.executability_of.kv -> $k, $v {
            @available_operations.push($k ~ '()') if $v;
            debug "$k : $v" if $IS_DEBUG;
        }
        return @available_operations;
    }

    =para
    Shadowverse::Entity::Player::load_deck()::
    load deck for Player

    method load_deck(Str:D $deck_file) {
        my ($deck_file_path, $data, $class, $card_count, $card_name);
        my (@cards_by_name, @deck_lines);
        my $user_deck_file = "./doc/deck/$deck_file";
        # check if deck file exists
        if not $user_deck_file.IO.e {
            error "No such file. Use $DEFAULT_DECK instead ";
            $deck_file_path = $DEFAULT_DECK;
        }
        else {
            $deck_file_path = $user_deck_file;
        }

        @deck_lines = $deck_file_path.IO.lines;
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
        self.shuffle_deck();
        return self;
    }

    =para
    Shadowverse::Entity::Player::shuffle_deck()::
    shuffle deck for Player

    method shuffle_deck() {
        @!deck .= pick(*); # pick all items
        return self;
    }

    =para
    Shadowverse::Entity::Player::end_turn()::
    Player have choise to end his turn and tell Game ends turn
    then Player.opponent_player takes over

    method end_turn() {
        debug "Player $.id has finished this turn ";
        # TODO rune count down/ do deathrattle
        return self;
    }

    =para
    Shadowverse::Entity::Player::concede()::
    Player have choise to concede and tell Game takes over

    method conceded() {
        debug "Player $.id has conceded, OMG ";
        return self;
    }

    method check_deck(--> Array:D){
        return @!deck;
    }
}

=para
Shadowverse::Entity::Player::
A robot or a human controls Player

class Player is Entity does Player_jobs  {
    # TODO add $HAS_LOADED_ALL_CARDS in enum
    method BUILDALL(|) {
        @PODS.append: $=pod;
        callsame;
        $.id = $ENTITY_COUNT;
        self;
    }
}
