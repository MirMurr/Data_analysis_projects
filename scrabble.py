#Scrabble

letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
points = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 4, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

#create a dictionary based on the above lists
letter_to_points = {key:value for key, value in zip(letters, points)}

#add 0 points to empty tiles
letter_to_points[" "] = 0

#define word score points
def score_word(word):
  point_total = 0
  for letter in word:
    point_total += letter_to_points.get(letter, 0)
  #indentation of return is very important otherwise it won´t return the right value
  return point_total

#test
print(score_word("BROWNIE"))

#create players and their words dictionary:
player_to_words = {"player1": ["BLUE", "TENNIS", "EXIT"], "wordNerd": ["EARTH", "EYES", "MACHINE"], "Lexi Con": ["ERASER", "BELLY", "HUSKY"], "Prof Reader": ["ZAP", "COMA", "PERIOD"]}

#empty dictionary to later store the players and their points
player_to_points = {}

#iterate through the player to words dictionary's all items (outer loop) and in the inner loop add the value of score_word to player_points to get how many points the given word is worth. After the inner loop finished add player as key and player_points as value to the above empty list player_to_points:
for player, words in player_to_words.items():
  player_points = 0
  for word in words:
    player_points += score_word(word)
  player_to_points[player] = player_points

#result
print(player_to_points)
