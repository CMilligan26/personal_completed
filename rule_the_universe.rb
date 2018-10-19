#Create database with enemy and player stats

enemies = {
  :enemy1 =>
  {
    :name => "Master Krull",
    :health => 100,
    :stamina => 20,
    :moves =>
    [
      {
        :move_name => "Krull Smash",
        :damage => 4,
        :cost => 8
      },
      {
        :move_name => "Power Beam",
        :damage => 7,
        :cost => 14
      }
    ]
  },
  :enemy2 =>
  {
    :name => "Lord Knoth",
    :health => 100,
    :stamina => 20,
    :moves =>
    [
      {
        :move_name => "Lord Wrath",
        :damage => 8,
        :cost => 15
      },
      {
        :move_name => "Flame",
        :damage => 2,
        :cost => 4
      }
    ]
  },
  :enemy3 =>
  {
    :name => "GammaTron",
    :health => 100,
    :stamina => 20,
    :moves =>
    [
      {
        :move_name => "Gamma Ray",
        :damage => 6,
        :cost => 12
      },
      {
        :move_name => "Tron Rush",
        :damage => 4,
        :cost => 6
      }
    ]
  },
  :enemy4 =>
  {
    :name => "Deadly Nightshade",
    :health => 100,
    :stamina => 20,
    :moves =>
    [
      {
        :move_name => "Sly Cut",
        :damage => 5,
        :cost => 10
      },
      {
        :move_name => "Shadow Pulse",
        :damage => 12,
        :cost => 17
      }
    ]
  }
}

player = {
  :name => nil,
  :health => 100,
  :stamina => 20,
  :moves =>
  [
    {
      :move_name => "Swift Jab",
      :damage => 5,
      :cost => 6
    },
    {
      :move_name => "Power Punch",
      :damage => 7,
      :cost => 13
    },
    {
      :move_name => "Power Kick",
      :damage => 10,
      :cost => 18
    }
  ]
}

#Define methods

def player_attack (player_stats, enemy)
  p "Time for #{player_stats[:name]} to attack!"
  p "#{enemy[:name]} has #{enemy[:health]} health and #{enemy[:stamina]} stamina"
  p "#{player_stats[:name]} has #{player_stats[:health]} health and #{player_stats[:stamina]} stamina"
  for moves in player_stats[:moves]
    p "Use #{moves[:move_name]} for #{moves[:cost]} stamina? Y or N?"
    choice = gets.chomp
    if choice.capitalize == "Y"
      if moves[:cost] > player_stats[:stamina]
        p "#{player_stats[:name]} doesn't have enough stamina!"
      else
        enemy[:health] -= moves[:damage]
        player_stats[:stamina] -= moves[:cost]
        p "#{player_stats[:name]} attacks with #{moves[:move_name]} and inflicts #{moves[:damage]} damage!"
        return [enemy[:health], player_stats[:stamina]]
      end
    end
  end
  p "#{player_stats[:name]} didn't attack!"
  return [enemy[:health], player_stats[:stamina]]
end

def enemy_attack (player_stats, enemy)
  p "#{enemy[:name]} is going to attack!"
  p "#{player_stats[:name]} has #{player_stats[:health]} health and #{player_stats[:stamina]} stamina"
  p "#{enemy[:name]} has #{enemy[:health]} health and #{enemy[:stamina]} stamina"

  enemy_moves = enemy[:moves]
  random_move = enemy_moves[rand(enemy_moves.size)]

  if random_move[:cost] > enemy[:stamina]
    p "#{enemy[:name]} tries to attack but fails!"
    return [player_stats[:health], enemy[:stamina]]
  else
    player_stats[:health] -= random_move[:damage]
    enemy[:stamina] -= random_move[:cost]
    p "#{enemy[:name]} attacks with #{random_move[:move_name]} and inflicts #{random_move[:damage]} damage!"
    return [player_stats[:health], enemy[:stamina]]
  end
end

def copy_hash(hash)
  Marshal.load(Marshal.dump(hash))
end

##Main Program

#Ask for players name and say hello
p "What is your characters name?"
name = gets.chomp
p "Welcome #{name}!"

#Initiate variables
new_game = "N"
all_enemies = enemies.values

#Start main loop
loop do

  #Pull information from the stats for the new game

  #Pull player stats
  current_player = copy_hash(player)
  current_player[:name] = name
  #Enemies

  #Clear the list of enemies if defeated for a brand new game
  if new_game.capitalize == "Y"
    all_enemies = nil
    all_enemies = enemies.values
    new_game = "N"
  end

  #Empty the random enemy
  random_enemy = "empty"
  #Create a variable to store a random number within the scope of the number of enemies
  rannum = rand(all_enemies.size)
  #Set the random enemy to the random enemy selected from the enemy list
  random_enemy = all_enemies[rannum]
  #Delete the enemy from the enemy list to prevent selecting the same enemy twice
  all_enemies.delete_at(rannum)


  #Begin battle
  p "#{current_player[:name]} will battle #{random_enemy[:name]}!"
  p "#{current_player[:name]} has #{current_player[:moves].count} moves!"
  #Display player moves
  for moves in current_player[:moves]
    p "#{current_player[:name]} has #{moves[:move_name]} which causes #{moves[:damage]} damage at a cost of #{moves[:cost]} stamina!"
  end
  p "It's #{current_player[:name]}'s turn first!"

  #While both are still alive, attack each other
  while random_enemy[:health] > 0 and current_player[:health] > 0 do
    #Player attack
    p_attack = player_attack(current_player, random_enemy)
    random_enemy[:health] = p_attack[0]
    current_player[:stamina] = p_attack[1]+7
    #If someone is dead stop attacking
    if random_enemy[:health] <= 0 or current_player[:health] <= 0
      break
    end
    #Enemy attack
    e_attack = enemy_attack(current_player, random_enemy)
    current_player[:health] = e_attack[0]
    random_enemy[:stamina] = e_attack[1]+7
  end

  #Tell the player when a character is killed and ask what they want to do next
  #Player killed
  if current_player[:health] <= 0
    p "#{current_player[:name]} is dead!"
    #Start new game?
    p "Do you want to start a new game? Y or N?"
    new_game = gets.chomp
    if new_game.capitalize == "N"
      break
    end
  #Enemy killed
  else
    p "#{random_enemy[:name]} is dead! #{current_player[:name].upcase} WINS!!!"
    #Defeated all enemies
    if all_enemies.count == 0
      p "#{current_player[:name].upcase} IS THE RULER OF THE UNIVERSE!!!"
      break
    #Move on to next enemy
    else
      p "Lets meet the next challenger!"
    end
  end
end
#End game or loop back to move on to next enemy or start new game
