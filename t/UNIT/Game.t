use Test;
use lib <lib>;
use Enum;
use Game;
use Player;
use Card;

my ($game_player1, $game_player2);
my (
    @deck_by_name_of_player1, @deck_by_name_of_player2,
    @deck_of_player1, @deck_of_player2,
);

use-ok 'Game',
    '  UNIT_Game_TC_001            |class Game ';

ok my $game_u001 = Game.new(),
    '  UNIT_Game_TC_002            |empty Game ';

is $game_u001.id(), 1,
    '  UNIT_Game_TC_003            |Entity ID ';

my $game_u002 = Game.new();
is $game_u002.id(), 1,
    '  UNIT_Game_TC_004            |Entity ID restart ';

isa-ok $game_u002.load_all_cards, $game_u002,
    '  UNIT_Game_TC_005            |load all cards by Game ';

for ^40 {
    @deck_of_player1[$_]= Card.new;
    @deck_of_player2[$_]= Card.new;
};
$game_player1 = Player.new(deck => @deck_of_player1);
$game_player2 = Player.new(deck => @deck_of_player2);

ok my $game_u003 = Game.new(
          player1 => $game_player1,
          player2 => $game_player2,
      ),
    '  UNIT_Game_TC_006            |Game with Player and Card ';

my $game_u004 = Game.new.load_all_cards();
is $game_u004.check_card('Fairy Wisp'), %DATA_OF_CARD{'Fairy Wisp'},
    '  UNIT_Game_TC_007            |check existing card ';

is $game_u004.check_card('Fairy_Wisp'), False,
    '  UNIT_Game_TC_008            |check non-existing card ';

ok my $game_u005 = Game.new(
          player1 => $game_player1,
          player2 => $game_player2,
      ).init(),
    '  UNIT_Game_TC_009            |roll first ';
sub in { return  (grep @^a, @^b) };
my @players_u005 = ($game_u005.first_player, $game_u005.second_player);
cmp-ok @players_u005, &in, (
        ($game_player1, $game_player2),
        ($game_player2, $game_player1),
),
    ' UNIT_Game_TC_010            |roll first ';




done-testing;
