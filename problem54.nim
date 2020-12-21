from strutils import split
from sugar import collect, `=>`
from algorithm import sort
from sequtils import mapIt

# Wins:
# 2, 1, 2, 1, 1
const
  exampleFile ="""5H 5C 6S 7S KD 2C 3S 8S 8D TD
5D 8C 9S JS AC 2C 5C 7D 8S QH
2D 9C AS AH AC 3D 6D 7D TD QD
4D 6S 9H QH QC 3D 6D 7H QD QS
2H 2D 4C 4D 4S 3C 3D 3S 9S 9D
"""
  realFile = slurp("problem54.txt")

type
  Suite = enum
    Hearts, Diamonds, Clubs, Spades
  CardValue = enum
    Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
  Card = object
    suite: Suite
    value: CardValue
  RankCategory = enum
    HighCard, OnePair, TwoPairs, ThreeOfAKind, Straight, Flush, FullHouse,
    FourOfAKind, StraightFlush, RoyalFlush
  Rank = object
    category: RankCategory
    cards: seq[int]
  Hand = object
    cards: array[5, Card]
    rank: Rank
  Game = object
    player1: Hand
    player2: Hand
    winner: range[0..2] ## 0 is tie, 1 is player1 wins, 2 is player2 wins.
const
  RanksWithAllCardsUsed = {Straight, Flush, StraightFlush, RoyalFlush}
  ## FullHouse is not included because it is handled specially.

func parseCard(s: string): Card =
  assert s.len == 2
  result.value =
    case s[0]
    of '2': Two
    of '3': Three
    of '4': Four
    of '5': Five
    of '6': Six
    of '7': Seven
    of '8': Eight
    of '9': Nine
    of 'T': Ten
    of 'J': Jack
    of 'Q': Queen
    of 'K': King
    of 'A': Ace
    else:
      assert false
      Two
  result.suite =
    case s[1]
    of 'H': Hearts
    of 'D': Diamonds
    of 'C': Clubs
    of 'S': Spades
    else:
      assert false
      Hearts

var
  games = collect(newSeq):
    for game in realFile.split('\n'):
    # for game in exampleFile.split('\n'):
      if game == "": continue
      let hands = game.split
      Game(
        player1: Hand(
          cards: [
            parseCard(hands[0]),
            parseCard(hands[1]),
            parseCard(hands[2]),
            parseCard(hands[3]),
            parseCard(hands[4]),
          ]
        ),
        player2: Hand(
          cards: [
            parseCard(hands[5]),
            parseCard(hands[6]),
            parseCard(hands[7]),
            parseCard(hands[8]),
            parseCard(hands[9]),
          ]
        )
      )

func findRank(h: var Hand) =
  var
    consecutiveValues = false
    sameSuite = false
  h.cards.sort((a, b) => cmp(a.value, b.value))
  let c = h.cards
  if c[0].suite == c[1].suite and c[0].suite == c[2].suite and
     c[0].suite == c[3].suite and c[0].suite == c[4].suite:
    sameSuite = true
  if c[0].value != Ace and
     c[1].value != Ace and
     c[2].value != Ace and
     c[3].value != Ace and
     c[0].value.succ == c[1].value and
     c[1].value.succ == c[2].value and
     c[2].value.succ == c[3].value and
     c[3].value.succ == c[4].value:
    consecutiveValues = true
  h.rank =
    if consecutiveValues and sameSuite and c[4].value == Ace:
      Rank(category: RoyalFlush, cards: @[0, 1, 2, 3, 4])
    elif consecutiveValues and sameSuite:
      Rank(category: StraightFlush, cards: @[0, 1, 2, 3, 4])
    elif c[0].value == c[1].value and
         c[0].value == c[2].value and
         c[0].value == c[3].value or
         c[1].value == c[2].value and
         c[1].value == c[3].value and
         c[1].value == c[4].value:
      let cards =
        if c[0].value == c[1].value: @[0, 1, 2, 3]
        else: @[1, 2, 3, 4]
      Rank(category: FourOfAKind, cards: cards)
    elif c[0].value == c[1].value and
         c[0].value == c[2].value and
         c[3].value == c[4].value or
         c[0].value == c[1].value and
         c[2].value == c[3].value and
         c[2].value == c[4].value:
      # Here cards is for ThreeOfAKind combination, because it should be
      # compared first, before OnePair in case of ties.
      let cards =
        if c[0].value == c[1].value and c[0].value == c[2].value: @[0, 1, 2]
        else: @[2, 3, 4]
      Rank(category: FullHouse, cards: cards)
    elif sameSuite:
      Rank(category: Flush, cards: @[0, 1, 2, 3, 4])
    elif consecutiveValues:
      Rank(category: Straight, cards: @[0, 1, 2, 3, 4])
    elif c[0].value == c[1].value and
         c[0].value == c[2].value or
         c[1].value == c[2].value and
         c[1].value == c[3].value or
         c[2].value == c[3].value and
         c[2].value == c[4].value:
      let cards =
        if c[0].value == c[1].value: @[0, 1, 2]
        elif c[3].value == c[4].value: @[2, 3, 4]
        else: @[1, 2, 3]
      Rank(category: ThreeOfAKind, cards: cards)
    elif c[0].value == c[1].value and
         c[2].value == c[3].value or
         c[0].value == c[1].value and
         c[3].value == c[4].value or
         c[1].value == c[2].value and
         c[3].value == c[4].value:
      let cards =
        if c[0].value == c[1].value and c[2].value == c[3].value: @[0, 1, 2, 3]
        elif c[0].value == c[1].value: @[0, 1, 3, 4]
        else: @[1, 2, 3, 4]
      Rank(category: TwoPairs, cards: cards)
    elif c[0].value == c[1].value or
         c[1].value == c[2].value or
         c[2].value == c[3].value or
         c[3].value == c[4].value:
      let cards =
        if c[0].value == c[1].value: @[0, 1]
        elif c[1].value == c[2].value: @[1, 2]
        elif c[2].value == c[3].value: @[2, 3]
        else: @[3, 4]
      Rank(category: OnePair, cards: cards)
    else:
      Rank(category: HighCard, cards: @[4])

func resolve(g: var Game) =
  findRank(g.player1)
  findRank(g.player2)
  if g.player1.rank.category > g.player2.rank.category:
    g.winner = 1
  elif g.player1.rank.category < g.player2.rank.category:
    g.winner = 2
  else:
    let
      cards1 = g.player1.cards
      cards2 = g.player2.cards
      rankCards1 = g.player1.rank.cards
      rankCards2 = g.player2.rank.cards
    # Ranks are same, compare cards from the rank
    for i in countdown(rankCards1.len - 1, 0):
      if cards1[rankCards1[i]].value > cards2[rankCards2[i]].value:
        g.winner = 1
        break
      elif cards1[rankCards1[i]].value < cards2[rankCards2[i]].value:
        g.winner = 2
        break
    if g.winner == 0 and g.player1.rank.category notin RanksWithAllCardsUsed:
      # Ranks are same, cards from rank are same, compare highest card in hand
      let
        notRankCards1 = block:
          var allCards = @[0, 1, 2, 3, 4]
          for i in rankCards1:
            allCards.delete(allCards.find(i))
          collect(newSeq):
            for i in allCards:
              cards1[i]
        notRankCards2 = block:
          var allCards = @[0, 1, 2, 3, 4]
          for i in rankCards2:
            allCards.delete(allCards.find(i))
          collect(newSeq):
            for i in allCards:
              cards2[i]
      for i in countdown(notRankCards1.len - 1, 0):
        if notRankCards1[i].value > notRankCards2[i].value:
          g.winner = 1
          break
        elif notRankCards1[i].value < notRankCards2[i].value:
          g.winner = 2
          break

var player1Wins = 0
for i, g in games.mpairs:
  resolve(g)
  if g.winner == 1: player1Wins.inc
echo player1Wins
