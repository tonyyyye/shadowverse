use v6.c;
use Test;
use Log::Async;
use lib <lib>;
use Entity;

logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));



use-ok 'Entity',
    'UNIT_Entity_000          |class Entity ';
ok my $entity_u001 = Entity.new(),
    'UNIT_Entity_001          |empty Entity ';


done-testing;
