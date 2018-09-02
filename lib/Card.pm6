use Log::Async;
use Enum;
use Entity;

logger.send-to('log/INFO_Card.log',  :level(INFO));
logger.send-to('log/DEBUG_Card.log', :level(DEBUG));

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

    ## user defined
    # parent Player, or the owner
    has $.Player is rw;
    has Bool $.is_selectable is default(True) is rw;
    # minion/spell/Hero/other
    has $.type is rw;

    =para
    Shadowverse::Entity::Card::is_playable()::
    check if Player can play a card with given target(s)

    # TODO check mana/legal
    method is_playable(Entity:D :$target? --> Bool:D) {
        # return False if $!cost > self.Player.mana
        if $target.defined {
            debug "check playing $!card_name with target";
            # $target.is_selectable();
            return True;
        }
        return True;
    }

    =para
    Shadowverse::Entity::Card::play()::
    play a card and do its battlecry

    method play(:$card_playing_target?) {
        if $card_playing_target {
            debug "You have chosen $card_playing_target as target";
            if self.is_playable($card_playing_target) {
                debug "Now playing";
                # TODO card action
            }
            else {
                error "not able to play"
            }
        }
        else {
            debug "Player has played $.card_name with no target";
        }
        return $!Player;
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
