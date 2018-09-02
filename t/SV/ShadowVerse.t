# To abort the test suite upon first failure
BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;
use Log::Async;
use Terminal::ANSIColor;
use JSON::Fast;
use lib <lib>;
use Game;
use Player;
use Card;

logger.send-to('log/INFO.log',  :level(INFO));
logger.send-to('log/ERROR.log', :level(ERROR));

my $game_index = 10010000;
my $tc_index = 0;
my (
    $blank_count,            $blank_content,
    $game_player1,           $game_player2,
    $deck_file_of_player1,   $deck_file_of_player2,
);
my (
    @deck_of_player1, @deck_of_player2,
);

sub case($text) {
    $game_index++;
    $tc_index++;
    $blank_count = 4 - $tc_index.log10.Int;
    $blank_content = " " x $blank_count;
    colored("$blank_content ALL_TC_$game_index          |$text",
        'bold black on_white');
}

subtest {
    ok my $game_10010001 = Game.new.load_all_cards(),
        case('an empty Game with json profile ');


    for ^40 {
        @deck_of_player1[$_] = Card.new();
        @deck_of_player2[$_] = Card.new();
    };
    $game_player1 = Player.new(deck => @deck_of_player1);
    $game_player2 = Player.new(deck => @deck_of_player2);
    ok my $game_10010002 = Game.new(
        player1 => $game_player1,
        player2 => $game_player2,
    ),
        case('Game with Player and deck ');
},
colored('Basic Game test ','bold blue on_yellow');


subtest {
    $game_index = 10020000;
    $tc_index = 0;
    $deck_file_of_player1 =  'one_card.deck';
    $deck_file_of_player2 =  'one_card.deck';
    $game_player1 = Player.new.load_deck($deck_file_of_player1);
    $game_player2 = Player.new.load_deck($deck_file_of_player2);

    ok my $game_10020001 = Game.new(
            player1 => $game_player1,
            player2 => $game_player2,
        ),
        case('Game with user defined one Card deck ');

    # is $game_10020001.init.first_player.deck[0].Player,
    #        $game_10020001.first_player,
    #        case('Game elements can recall its has-parent ');
},
colored('Game with simple elements ','bold blue on_yellow');


subtest {
    $game_index = 10030000;
    $tc_index = 0;

    $deck_file_of_player1 =  'more_cards.deck';
    $deck_file_of_player2 =  'more_cards.deck';
    $game_player1 = Player.new.load_deck($deck_file_of_player1);
    $game_player2 = Player.new.load_deck($deck_file_of_player2);

    my $game_10030001 = Game.new(
           player1 => $game_player1,
           player2 => $game_player2,
        );
    use-ok 'Game', case('use ok ');
},
colored('more complicated Game  ','bold blue on_yellow');


done-testing;
