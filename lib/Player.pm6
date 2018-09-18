use Log::Async;
use Enum;
use Entity;
use Card;
use Hero;

logger.send-to("$LOG_DIR/INFO_Player.log", :level(INFO));
logger.send-to("$LOG_DIR/ERROR_Player.log", :level(ERROR));
logger.send-to("$LOG_DIR/DEBUG_Player.log", :level(DEBUG));

=para
Shadowverse::Entity::Player::Player_jobs::
What a Player can do.

role Player_jobs {
    ## Player attributes
    has $.Game is rw;
    has $.opponent_player is rw;
    has $.Hero is rw;
    has Int $.class is rw;
    has Int $.mana is rw;
    has Int $.max_mana is rw;
    has Bool $.is_able_to_evolve is default(False) is rw;
    has Int $.evolve_chance is default(3);
    has Int $.evolve_countdown is default(3);
    has Bool %.activity_of_special_power is rw;
    # notice: every time deck is changed, remember to shuffle_deck
    has Card @.deck is rw;
    has Card @.hand is rw;
    # TODO add 'rush' when Player evolve a minion
    has Card @.field is rw;
    has Card @.graveyard is rw;


    has Int $.turn_count is rw;
    ## interfaces which are not open to user
    has Str $!deck_name;
    has Bool %.executability_of is rw;
    has Int $!max_field_length is default(5);
    # has Bool @.is_slot_occupied is default( False xx  5);
    has Str @!unavailable_methods;
    # indicates which operations that Player cannot choose
    has Str @.seal_methods is rw;
    has Int @.hand_id is rw;
    has Int @.deck_id is rw;

    ## methods that Player run when initialize

    =para
    Shadowverse::Entity::Player::init()::
    Initialize Player when Game starts

    multi method init() {
        $!turn_count = 0;
        # first True(1) + id(1) / first False(0) + id(2)
        if self.id + $IS_PLAYER1_FIRST.Numeric == 2 {
            $!evolve_countdown++;
        }
        else {
            $!evolve_chance++;
        }
        return self;
    }
    multi method init($deck_file) {
        self.init.load_deck($deck_file)
            .init_hero($!class)
            .init_special_power($!class);
        return self;
    }

    =para
    Shadowverse::Entity::Player::init_hero()::
    Initialize Hero when the deck is loaded

    method init_hero($class) {
        # TODO Hero should have life
        # $.Hero = Hero.new(class=$class);
        return self;
    }

    =para
    Shadowverse::Entity::Player::init_special_power()::
    Initialize special power for different $.class

    method init_special_power($class) {
        # TODO Hero special_power
        # 8 powers with 8 counters
        return self;
    }

    =para
    Shadowverse::Entity::Player::draw()::
    draw Card (passively)

    multi method draw() {
        my $card = self.deck.pop;
        $card.zone = %CODE_OF_ZONE{'HAND'};
        @!hand_id.push($card.id);
        self.hand.push($card);
        return self;
    }
    multi method draw($card_name) {
        self.shuffle_deck();
        my ($deck_card, $card_id);
        # look for $card_name
        for ^@!deck -> $deck_index {
            $deck_card = @!deck[$deck_index];
            if $deck_card.card_name ~= $card_name {
                $deck_card.zone = %CODE_OF_ZONE{'HAND'};
                $card_id = $deck_card.card_id;
                @!hand_id.push($deck_card.card_id);
                @!deck = @!deck.hyper.grep({ $_.card_id != $card_id }).list;
                @!hand.push($deck_card);
                debug "DEBUG_Player :
                   no. $deck_index Card is @!deck[$deck_index]";
                last;
            }
        }
        # my $card = self.deck.shift;
        #
        # self.hand.push($card);

        return self;
    }

    =para
    Shadowverse::Entity::Player::evolve()::
    change atk/life/effect and trigger everything else

    method evolve($minion) {
        if $!is_able_to_evolve {
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
    Shadowverse::Entity::Player::let()::
    Player can evolve a minion or control it to attack enermy

    method let(:$minion_id, :$action, :$target_id?) {
        return self;
    }

    =para
    Shadowverse::Entity::Player::play()::
    Player can play Card

    multi method play(Card:D $card, :$target?) {
        $target.defined ?? $card.be_played($target) !!
            # $targets.defined ??  $card.be_played($targets) !!
                $card.be_played();
        @!hand = @!hand.hyper.grep({ $_.id != $card.id }).list;
        return self;
    }
    # multi method play(:$target?, :@targets?) {
    #     my $card = $.hand[*-1];
    #     $target.defined ??
    #         @targets.defined ??
    #             $card.be_played(@targets) !!
    #             $card.be_played($$target) !!
    #             $card.be_played();
    #     @!hand = @!hand.hyper.grep({ $_.id == $card.id }).list;
    #     return self;
    # }

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
                 if not %DATA_OF_CARD{$card_name}.defined {
                     error "no such Card in set";
                     return False;
                 }
                for ^$card_count {
                    my $card =
                        %DATA_OF_CARD{$card_name}.clone;
                    $card.Player = self;
                    $card.zone = %CODE_OF_ZONE{'DECK'};
                    @!deck.push($card);
                    @!deck_id.push($card.id);
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
        @!deck_id.splice;
        for @.deck -> $card {
            @!deck_id.push($card.card_id);
        }
        return self;
    }

    =para
    Shadowverse::Entity::Player::end_turn()::
    Player have choise to end his turn and tell Game ends turn
    then Player.opponent_player takes over

    method end_turn() {
        debug "Player $.id has finished this turn ";
        self.finish_turn();
        self.opponent_player.start_turn();
        # TODO rune count down/ do deathrattle
        return self;
    }

    =para
    Shadowverse::Entity::Player::start_turn()::
    your opponent player choose to

    method start_turn() {
        $!turn_count++;
        $!is_able_to_evolve = $!evolve_countdown <= 0 ?? True !! False;
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
