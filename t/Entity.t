use v6.c;
use Test;
use Log::Async;
use lib <lib>;

logger.send-to("log/INFO.log",  :level(INFO));
logger.send-to("log/ERROR.log", :level(ERROR));
info "This is Entity test suite";
error "Error message are listed here";




use-ok 'Entity';
done-testing;
