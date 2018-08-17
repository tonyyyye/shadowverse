use Log::Async;
use Enum;


logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));

=para
Shadowverse::Entity::Entity_jobs::
What a Entity can do.

role Entity_jobs {
    =para
    Shadowverse::Entity::help()::
    Show description of a method
    :parameters: The method/instance name that you want to know
    :return: A string form of the description .

    method help(Str:D $entity --> Str:D){
        @PODS.append: $=pod;
        my %comment_of;
        for @PODS -> $pod {
            for $pod.contents -> $pod_content {
                my $content = $pod_content.contents;
                my @contents = split('::', $content);
                %comment_of{@contents[*-2]} = @contents[*-1];
            }
        }
        return %comment_of{$entity};
    }

    =para
    Shadowverse::Entity::entity()::
    :parameters: None
    :return: A structured form of its all attributes and methods

    method entity(--> Hash:D) {
        my %entity_hash;
        my ($entity_key,$entity_value);
        for self.^attributes() -> $attribute {
            if  ( $entity_value = $attribute.get_value(self) ) {
                $entity_key = split('!',$attribute.Str)[1];
                %entity_hash{$entity_key} = $entity_value;
            }
        }
        for self.^methods() -> $method {
            $entity_key = $method.name() ~ '()';
            %entity_hash{$entity_key} = 'IS_A_METHOD';
        }
        return %entity_hash;
    }
}

=para
Shadowverse::Entity::
Everything is an Entity .

class Entity does Entity_jobs {
    has Int $.id is rw;
    has Str $.name is default(%CODE_OF{'DEFAULT_STR'}) is rw;
    has Int $.type is default(%TYPE_OF{'ENTITY'});
    # initial things here
    method BUILDALL(|) {
        @PODS.append: $=pod;
        # call the parent classes (or default) BUILDALL
        callsame;
        $.id = $ENTITY_COUNT += 1;
        # return the fully built object
        self;
    }
}
