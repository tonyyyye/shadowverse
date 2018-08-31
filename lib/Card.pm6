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
    has Bool $.selectable is rw;
    # minion/spell/other
    has $.type is rw;

    =para
    Shadowverse::Entity::Card::check_selectable()::
    check if a target Card can be selected

    # TODO check selectable
    method check_selectable($target) {
        return True;
    }

    =para
    Shadowverse::Entity::Card::check_playable()::
    check if Player can play a card with given target(s)

    # TODO check mana/legal
    method check_playable(:$target?) {
        if $target.defined {
            $target.check_selectable();
        }
        return True;
    }

    =para
    Shadowverse::Entity::Card::play()::
    play a card and do its battlecry

    method play(:$target?) {
        self.check_playable();
        if $target {
            debug("You have chosen $target as target");
        }
        else {
            debug("Player has played $.card_name with no target");
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
