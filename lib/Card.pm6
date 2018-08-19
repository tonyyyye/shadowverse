use Log::Async;
use Enum;
use Entity;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

=para
Shadowverse::Entity::Card::Card_jobs::
What a Card can do.

role Card_jobs {
    has $.clan;
    has $.skill;
    has $.cost;
    has $.life;
    has $.base_card_id;
    has $.org_skill_disc;
    has $.atk;
    has $.get_red_ether;
    has $.normal_card_id;
    has $.copyright;
    has $.tokens;
    has $.format_type;
    has $.evo_description;
    has $.card_set_id;
    has $.card_name;
    has $.char_type;
    has $.skill_option;
    has $.rarity;
    has $.foil_card_id;
    has $.evo_skill_disc;
    has $.cv;
    has $.restricted_count;
    has $.card_id;
    has $.tribe_name;
    has $.org_evo_skill_disc;
    has $.evo_life;
    has $.use_red_ether;
    has $.is_foil;
    has $.skill_disc;
    has $.evo_atk;
    has $.description;
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
