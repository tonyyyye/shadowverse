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
my (%expected_hash,);
multi sub in { return  (grep @^a, @^b) };
multi sub in { return  (grep $^a, @^b) };

use-ok 'Game',
    '  UNIT_Game_TC_001            |class Game ';

ok my $game_u001 = Game.new(),
    '  UNIT_Game_TC_002            |empty Game ';

is $game_u001.id(), 0,
    '  UNIT_Game_TC_003            |Entity ID ';

my $game_u002 = Game.new();
is $game_u002.id(), 0,
    '  UNIT_Game_TC_004            |Entity ID restart ';

isa-ok $game_u002.load_all_cards(), Game,
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

ok my $game_u004 = Game.new.load_all_cards(),
    '  UNIT_Game_TC_007            |load_all_cards ';
is $game_u004.check_card('Fairy Wisp'), %DATA_OF_CARD{'Fairy Wisp'},
    '  UNIT_Game_TC_008            |check existing card ';

%expected_hash = BLANK => 0;
is $game_u004.check_card('Fairy_Wisp'), %expected_hash,
    '  UNIT_Game_TC_009            |check non-existing card ';

# reset %DATA_OF_CARD
%DATA_OF_CARD =
    SHADOWVERSE => %BLANK_CARD,
;

# init once is ok
ok my $game_u005 = Game.new.init(),
    ' UNIT_Game_TC_010            |Game init ';

my @players_id_u005 =
    ($game_u005.first_player, $game_u005.second_player);
cmp-ok (@players_id_u005), &in, (
    ($game_u005.player1, $game_u005.player2),
    ($game_u005.player2, $game_u005.player1),
),
    ' UNIT_Game_TC_011            |check random roll ';

cmp-ok $game_u005.first_player.opponent_player.id, &in, [1,2],
    ' UNIT_Game_TC_012            |check opponent_player with all forms ';






done-testing;
