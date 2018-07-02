use v6.c;
use Log::Async;
use Enum;


=para
Shadowverse::Entity::Entity_jobs::
What a Entity can do.

role Entity_jobs {
    has Int $.entity_id is rw; #TODO is required
}

=para
Shadowverse::Entity::
Everything is an Entity.

class Entity does Entity_jobs {

}
