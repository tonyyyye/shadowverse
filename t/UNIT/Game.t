use Test;
use lib <lib>;
use Game;
use Player;
use Card;

my ($game_player1, $game_player2);
my (
    @deck_by_name_of_player1, @deck_by_name_of_player2,
    @deck1, @deck2,
);

use-ok 'Game',
    'UNIT_Game_TC_001            |class Game ';

ok my $game_u001 = Game.new(),
    'UNIT_Game_TC_002            |empty Game ';

is $game_u001.id(), 1,
    'UNIT_Game_TC_003            |Entity ID ';

my $game_u002 = Game.new();
is $game_u002.id(), 1,
    'UNIT_Game_TC_004            |Entity ID restart ';

isa-ok $game_u002.load_all_cards, Hash,
    'UNIT_Game_TC_006            |load all cards by Game ';


for ^40 {
    @deck1[$_]= Card.new;
    @deck2[$_]= Card.new;
};
$game_player1 = Player.new(deck => @deck1);
$game_player2 = Player.new(deck => @deck2);

ok my $game_u003 = Game.new(
          player1 => $game_player1,
          player2 => $game_player2,
      ),
    'UNIT_Game_TC_006            |Game with Player and Card ';

is $game_u003.players(), ($game_player1, $game_player2),
    'UNIT_Game_TC_007            |Game.players() ';

is $game_u003.switch_players(), ($game_player2, $game_player1),
    'UNIT_Game_TC_008            |Game.switch_players() ';


# TODO modify these cases after being fully implemented Card
# is $game_u002.check_card(900111020), True,
#     'UNIT_Game_TC_004            |can find a existing card ';
# is $game_u002.check_card(13579), False,
#     'UNIT_Game_TC_005            |can alert a non-existing card ';







done-testing;
