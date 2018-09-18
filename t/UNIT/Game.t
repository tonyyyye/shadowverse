use Test;
use lib <lib>;
use Enum;
use Game;
use Player;
use Card;

my ($card,         $game,         $expected_result,
    $game_player1, $game_player2, $game_player
);
my (
    @deck_of_player1, @deck_of_player2,
);
my (%expected_hash,);
multi sub in { return  (grep @^a, @^b) };
multi sub in { return  (grep $^a, $^b) };

## basic tests
use-ok 'Game',
    '  UNIT_Game_TC_001       |class Game ';

ok my $game_u001 = Game.new(),
    '  UNIT_Game_TC_002       |empty Game ';

is $game_u001.id(), 0,
    '  UNIT_Game_TC_003       |Entity ID ';

my $game_u002 = Game.new();
is $game_u002.id(), 0,
    '  UNIT_Game_TC_004       |Entity ID restart ';

## advanced tests
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
    '  UNIT_Game_TC_005       |Game with Player and Card ';

ok my $game_u004 = Game.new.load_all_cards(),
    '  UNIT_Game_TC_006       |load all cards by Game ';

is $game_u004.check_card('Fairy Wisp'), %DATA_OF_CARD{'Fairy Wisp'},
    '  UNIT_Game_TC_007       |check existing card ';

$expected_result = BLANK => 0;
is $game_u004.check_card('non-existing Wisp'), $expected_result,
    '  UNIT_Game_TC_008       |check non-existing card ';

# reset %DATA_OF_CARD
%DATA_OF_CARD{'SHADOWVERSE'} = Card.new();

# init once is ok
ok my $game_u005 = Game.new.init(),
    '  UNIT_Game_TC_009       |Game init ';

my @players_id_u005 =
    ($game_u005.first_player, $game_u005.second_player);
cmp-ok (@players_id_u005), &in, (
    ($game_u005.player1, $game_u005.player2),
    ($game_u005.player2, $game_u005.player1),
),
    ' UNIT_Game_TC_010       |check random roll ';

ok $game_u005.first_player.opponent_player.id <= 2 ,
    ' UNIT_Game_TC_011       |check opponent_player with all forms ';






done-testing;
