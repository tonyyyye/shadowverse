use v6.c;
use Test;
use Log::Async;
use lib <lib>;

logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));



use-ok 'Entity', 'UNIT_Entity_000          |empty Entity ';
done-testing;
