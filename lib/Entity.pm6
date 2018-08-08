use Log::Async;
use Enum;


logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));

=para
Shadowverse::Entity::Entity_jobs::
What a Entity can do.

role Entity_jobs {
    =para
    Shadowverse::Entity::help::
    Show description of a method
    :parameters: The method/instance that you want to know
    :return: A string form of its own .

    method help(Str:D $entity --> Str:D){
        @PODS.append: $=pod;
        my %comment_of;
        for @PODS -> $pod {
            for $pod.contents -> $pod_content {
                my $content = $pod_content.contents;
                my @contents = split('::', $content);
                %comment_of{ @contents[*-2]} = @contents[*-1];
            }
        }
        return %comment_of{$entity};
    }

    =para
    SV::Entity::entity::
    :parameters: None
    :return: A structured form of its all attributes

    method entity(--> Hash:D) {
        my %entity_hash;
        my $entity_key;
        my $entity_value;
        for self.^attributes() -> $attribute {
            if  ( $entity_value = $attribute.get_value(self) ) {
                # $attribute.^methods.perl.say;
                # $attribute.^attributes.perl.say;
                # $attribute.^mro.perl.say;

                $entity_key = split('!',$attribute.Str)[1];
                %entity_hash{$entity_key} = $entity_value;
            }
        }
        return %entity_hash;
    }
}

=begin Entity
Shadowverse::Entity::
Everything is an Entity .
=end Entity

class Entity does Entity_jobs {
    has Int $.id is rw; #TODO is required
    has Str $.name is default('SV') is rw;
    has Int $.type is default(%TYPE_OF{'ENTITY'});
    method BUILDALL(|) {# initial things here
        @PODS.append: $=pod;
        callsame;   # call the parent classes (or default) BUILDALL
        $.id = $ENTITY_COUNT += 1;
        self; # return the fully built object
    }
}
