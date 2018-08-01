use v6.c;
use Log::Async;
use Enum;

logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));

=para
Shadowverse::Entity::Entity_jobs::
What a Entity can do.

role Entity_jobs {
    has Int $.entity_id is rw; #TODO is required

    =para
    Shadowverse::Entity::help::
    Show description of a method 

    method help($entity){
        my %comment_of;
        for $=pod -> $pod {
            for $pod.contents -> $pod_content {
                my $content = $pod_content.contents;
                my @contents = split('::', $content);
                %comment_of{ @contents[*-2]} = @contents[*-1];
            }
        }
        return %comment_of{$entity};
    }

    =para
    SV::Entity::entity()::<Debug toolset>

    method entity() {
        my Str $entity;
        for self.^attributes(:local) -> $attribute {
            if  ( $attribute.get_value(self)  ) {
                # $attribute.^methods.perl.say;
                # $attribute.^attributes.perl.say;
                #$attribute.^mro.perl.say;
                $entity ~= "$attribute.Str\t\t:"
                           ~ $attribute.get_value(self)
                           ~ "\n";
            }
        }
        return $entity;
    }
}

=para
Shadowverse::Entity::
Everything is an Entity.

class Entity does Entity_jobs {
    method BUILDALL(|) {# initial things here
        callsame;   # call the parent classes (or default) BUILDALL
        $.entity_id = $entity_count += 1;
        self; # return the fully built object
    }
}
