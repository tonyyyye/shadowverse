# To abort the test suite upon first failure
BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;
use Log::Async;
use Terminal::ANSIColor;
use lib <lib>;
use Game;
use Player;
use Card;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

my $game_index = 10000000;
my (
    $blank_count, $blank_content,
    $game_player1, $game_player2,
);
my (
    @deck_by_name_of_player1, @deck_by_name_of_player2,
    @deck_of_player1, @deck_of_player2,
);

sub case($text) {
    $game_index++;
    $blank_count = log10($game_index - 10000000);
    $blank_content = 5 - $blank_count xx $blank_count;
    colored("$blank_content ALL_TC_$game_index          |$text",
        'bold black on_white');
}

subtest {
    ok my $game_10000001 = Game.new.load_all_cards(),
        case('an empty Game ');

    for ^40 {
        @deck_of_player1[$_] = Card.new;
        @deck_of_player2[$_] = Card.new;
    };
    $game_player1 = Player.new(deck => @deck_of_player1);
    $game_player2 = Player.new(deck => @deck_of_player2);

    ok my $game_10000002 = Game.new(
        player1 => $game_player1,
        player2 => $game_player2,
    ),
        case('Game with Player and deck ');
},
colored('Basic Game test ','bold blue on_yellow');

subtest {
    @deck_by_name_of_player1 =  [ 'Blessings of Creation', ];
    @deck_by_name_of_player2 =  [ 'Fairy Wisp', ];
    $game_player1 = Player.new.load_deck(@deck_by_name_of_player1);
    $game_player2 = Player.new.load_deck(@deck_by_name_of_player2);
    ok my $game_10000002 = Game.new(
            player1 => $game_player1,
            player2 => $game_player2,
        ),
        case('Game with user defined one Card deck ');
},
colored('Game with simple elements ','bold blue on_yellow');
done-testing;
