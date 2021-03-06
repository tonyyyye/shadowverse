use Log::Async;
use Enum;
use Entity;

logger.send-to("$LOG_DIR/INFO_Card.log",  :level(INFO));
logger.send-to("$LOG_DIR/DEBUG_Card.log", :level(DEBUG));
logger.send-to("$LOG_DIR/ERROR_Card.log", :level(ERROR));

=para
Shadowverse::Entity::Card::Card_jobs::
What a Card can do.

role Card_jobs {
    # json defined
    has $.clan is rw;
    has $.skill is rw;
    has $.cost is rw;
    has $.life is rw;
    has $.base_card_id is rw;
    has $.org_skill_disc is rw;
    has $.atk is rw;
    has $.get_red_ether is rw;
    has $.normal_card_id is rw;
    has $.copyright is rw;
    has $.tokens is rw;
    has $.format_type is rw;
    has $.evo_description is rw;
    has $.card_set_id is rw;
    has $.card_name is rw;
    has $.char_type is rw;
    has $.skill_option is rw;
    has $.rarity is rw;
    has $.foil_card_id is rw;
    has $.evo_skill_disc is rw;
    has $.cv is rw;
    has $.restricted_count is rw;
    has $.card_id is rw;
    has $.tribe_name is rw;
    has $.org_evo_skill_disc is rw;
    has $.evo_life is rw;
    has $.use_red_ether is rw;
    has $.is_foil is rw;
    has $.skill_disc is rw;
    has $.evo_atk is rw;
    has $.description is rw;

    has Int $.type is default(%TYPE_OF{'CARD'});
    ## user defined
    # parent Player, or the owner
    has $.Player is rw;
    # countdown for rune
    has Int $!count_down;
    has Int $.zone is default(%CODE_OF_ZONE{'INFINITY'}) is rw;
    # minion/spell/Hero/other
    has Bool $.is_minion is rw;
    ## function
    has Bool $.is_selectable is default(True) is rw;
    has Bool $.can_attack is rw;
    has @.battlecry_targets is rw;

    multi method new($card_name) {
        debug "Creating [$card_name]";
        # return self.bless(:$card_name);
        return %DATA_OF_CARD{$card_name};
    }

    =para
    Shadowverse::Entity::Card::is_playable()::
    check if Player can play a card with given target(s)

    # TODO check mana/legal
    method is_playable(Entity:D :$target? --> Bool:D) {
        if $!cost < $!Player.mana {
            error "not enough mana";
        }
        if $target.defined {
            debug "check playing $!card_name with target";
            # $target.is_selectable();
            return True;
        }
        return True;
    }

    =para
    Shadowverse::Entity::Card::be_played()::
    play a card and do its battlecry

    method be_played(:$target?) {
        # Card can have one of these:
        # a:only one user-selected target with other fixed targets
        # b:random target yield or all together
        # c:all the targets that are available by description

        if $target.defined {
            debug "You have chosen $target as target";
            if self.is_playable($target) {
                debug "Now playing";
            }
            else {
                error "Card.be_played(): not able to play";
            }
        }
        # TODO strictly when no fixed targets exists. AOE can be played
        else {
            debug "Player has played $.card_name with no target";
        }
        # played in field
        if ($!type == %TYPE_OF{'SPELL'}) {
            $!zone = %CODE_OF_ZONE{'GRAVEYARD'};
        }
        else {
            $!zone = %CODE_OF_ZONE{'FIELD'};
            $!Player.field.push(self);
        }
        # TODO card action
        return self;
    }
    method countdown() {
        if $!type != %TYPE_OF{'RUNE'} {
            error 'Not a rune, cannot countdown';
            return False;
        }
        $!count_down--;
        # FIXME check_death;
        return self;
    }

    =para
    Shadowverse::Entity::Card::is_able_to_attack()::
    check a minion's attack choise is legal

    method is_able_to_attack($target) {
        # if $target.id < 1
        # check $target exists
        # say $target.type ~~ m/minion|Hero/;
        return True;
    }

    =para
    Shadowverse::Entity::Card::attack()::
    a minion attack another minion or Hero

    method attack($target) {
        # if not self.is_able_to_attack($target) {
        #     error "$target cannot be attack target ";
        # }
        debug "attack [yy]";
        return self;
    }
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
