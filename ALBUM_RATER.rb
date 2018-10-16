#Things to add:
#If rating system changes, ask to reevaluate every album above the top score
#Display: highest rated albums above a certain number, lowest rated albums below a certain number, albums for a certain rating, highest to lowest, lowest to highest, all artists only, all albums only, specific album, improve the way info is displayed
#Add artists and albums of the same name (artistname(2), albumname(2))
#Rewrite program using class containing hashes and procs for calling text

#Set standard rating system
$toprating = "5"
$bottomrating = "0"
$ratingset = "false"

# If a file does not exist, create one, if its does, read it into the array

def get_line_from_file(path, line)
	result = nil
	File.open(path, "r") do |f|
    		while line > 0
      			line -= 1
      			result = f.gets
    		end
  	end
	return result
end
#Complete

$list = []

if File.file?("albumratings.txt") == false
	File.new("albumratings.txt", "w+")
else
	linecount = 1
	loop do
		if get_line_from_file("albumratings.txt",linecount) != nil
			$list.push(get_line_from_file("albumratings.txt",linecount).tr("\n", ""))
			linecount += 1
		else	
			break
		end
	end
	$bottomrating = $list[0]
	$toprating = $list[1]
	$ratingset = $list[2]
	$list.delete_at(0)
	$list.delete_at(0)
	$list.delete_at(0)
end
#Complete

# Main menu: add, delete, display.

def mainmenu
	loop do
		puts " "
		puts "Welcome to ALBUM RATER!"
		puts " "
		puts "What would you like to do? "
		puts "(type 'add' to add an artist or album.) "
		puts "(type 'delete' to delete an artist or album.) "
		puts "(type 'update' to update an artist name or album details.) "
		puts "(type 'display' to view all artists or a specific artist.) "
		if $ratingset == "false"
			puts "(type 'rating' to set your rating system.) "
		end
		puts "(type 'exit' to come back to this menu at any point.) "
		puts "(type 'end' to close ALBUM RATER!) "
		puts " "
		puts "The current rating system is #{$bottomrating} to #{$toprating}"
		puts " "
		$firstchoice = gets.chomp.capitalize
		if $ratingset == "false"
			if $firstchoice == "Rating"
				break
			end
		end
		if $firstchoice == "Add" or $firstchoice == "Delete" or $firstchoice == "Update" or $firstchoice == "Display" or $firstchoice == "Exit" or $firstchoice == "End"
			break
		elsif $firstchoice.empty? == true
			puts " "
			puts "You forgot to type an option!"
		else	
			puts " "
			puts "Enter valid choice."
		end
	end
end
#Complete

#Set rating system

def setrating
	puts " "
	puts "Time to set your rating system! "
		loop do
			puts " "
			puts "Enter your lowest possible numerical score "
			puts " "
			$bottomrating = gets.chomp
			if $bottomrating.to_i.to_s != $bottomrating
				puts " "
				puts "You did not enter a number!"
			else
				puts " "
				puts "Lowest score set to #{$bottomrating}!"
				break
			end
		end
		#Complete
		loop do
			puts " "
			puts "Enter your highest possible numerical score "
			puts " "
			$toprating = gets.chomp
			if $toprating.to_i.to_s != $toprating
				puts " "
				puts "You did not enter a number!"
			else
				puts " "
				puts "Highest score set to #{$toprating}!"
				break
			end
		end
		#Complete
	$ratingset = "true"
	puts " "
	puts "Your rating system is set to #{$bottomrating} to #{$toprating}!"
end
#Complete

# Add Menu

def addmenu
	loop do
		puts " "
		puts "Would you like to add an 'Artist' or an 'Album'? "
		puts " "
		$secondchoice = gets.chomp.capitalize
		if $secondchoice == "Artist" or $secondchoice == "Album" or $secondchoice == "Exit"
			break
		elsif $secondchoice.empty? == true
			puts " "
			puts "You forgot to type an option!"
		else
			puts " "
			puts "Enter valid choice."
		end
	end
end
#Complete

# Add New Artist

def addartist
	if $secondchoice == "Artist"
		loop do
			puts " "
			puts "What Artist would you like to add? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$artist = gets.chomp
			if $artist.downcase != "back to main menu"
				if $list.index("Artist: #{$artist}") != nil
					puts " "
					puts "Artist already added!"
				elsif $artist.empty? == true
					puts " "
					puts "You forgot to type the artists name!"
				else 	
					$list.push("Artist: #{$artist}")
					$currentartist = $list.index("Artist: #{$artist}")
					puts " "
					puts "#{$artist} added! "
					break
				end
			else
				break
			end
		end 
	end
end
#Complete

# Add album(s) after adding new artist menu

def alsoaddalbummenu
	loop do
		puts " "
		puts "Would you like to add an Album for #{$artist}? "
		puts " "
		$thirdchoice = gets.chomp.capitalize
		if $thirdchoice == "Yes" or $thirdchoice == "No" or $thirdchoice == "Exit" 
			break
		elsif $thirdchoice.empty? == true
			puts " "
			puts "You forgot to type an option!"
		else
			puts " "
			puts "Enter valid choice."
		end
	end
end
#Complete

# Add album(s) after adding new artist

def alsoaddalbum
	loop do
		puts " "
		puts "What Album would you like to add? "
		puts "(Please type 'back to main menu' to exit.)"
		puts " "
		$album = gets.chomp
		if $album.empty? == true
			puts " "
			puts "You forgot to type the albums name!"
		else
			break
		end
	end
	#Complete
	if $album.downcase != "back to main menu"
		loop do	
			puts " "
			puts "What Rating would you like to give it? (from #{$bottomrating} to #{$toprating})"
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$rating = gets.chomp
			if $rating.empty? == true
				puts " "
				puts "You forgot to type the rating!"
			else
				if $rating.to_i.to_s != $rating
					puts " "
					puts "You did not enter a number!"
				else
					if $rating.to_i.to_s == $rating
						if ($bottomrating.to_i..$toprating.to_i) === $rating.to_i
							break
						else
							puts " "
							puts "You did not type a number between #{$bottomrating} and #{$toprating}!"
						end
					end
							
				end
			end
		end
	end
	#Complete
	if $rating.downcase != "back to main menu"
		loop do
			puts " "
			puts "Comments? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$comment = gets.chomp	
			if $comment.empty? == true
				puts " "
				puts "No comments? OK!"
				$comment = "No comments"
				break
			else
				break
			end
		end
	end
	#Complete
	if $comment.downcase != "back to main menu"
		$list.push("Album: #{$album}","Rating: #{$rating}","Comments: #{$comment}")
		puts " "
		puts "#{$album} added!"
		loop do
			puts " "
			puts "Would you like to add another Album for #{$artist}? "
			puts " "
    			$fourthchoice = gets.chomp.capitalize
			if $fourthchoice == "Yes" or $fourthchoice == "No" or $fourthchoice == "Exit" 
				break
			elsif $fourthchoice.empty? == true
				puts " "
				puts "You forgot to type an option!"
			else
				puts " "
				puts "Enter valid choice."
			end
		end
	end
	#Complete
end
#Complete

# Add album to which existing artist?

def whichartistaddalbum
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "Which Artist do you want to add an album for? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$artist = gets.chomp
			if $artist.empty? == true
				puts " "
				puts "You forgot to type the artists name!"
			elsif $artist.downcase == "back to main menu"
				break
			else 
				if $list.index("Artist: #{$artist}") != nil
					$currentartist = $list.index("Artist: #{$artist}")
					break
				else
					puts " "
					puts "This artist does not exist! "
				end	
			end
		end
	end
end
#Complete

# Add album if artist exists

def addalbum
	$currentartist += 1
	loop do
		if $list[$currentartist].to_s.include?("Artist: ") == true or $list[$currentartist] == nil
			break
		else
			$currentartist += 1
		end
	end
	#Complete
	if $list.none? != true
		if $artist.downcase != "back to main menu"
			loop do
				puts " "
				puts "Which album do you want to add for #{$artist}? "
				puts "(Please type 'back to main menu' to exit.)"
				puts " "
				$album = gets.chomp
				if $album.empty? == true
					puts " "
					puts "You forgot to type the albums name!"

				else
					break
				end
			end
		end
		#Complete
		if $artist.downcase != "back to main menu" or $album.downcase != "back to main menu"
			loop do	
				puts " "
				puts "What Rating would you like to give it? (from #{$bottomrating} to #{$toprating})"
				puts "(Please type 'back to main menu' to exit.)"
				puts " "
				$rating = gets.chomp
				if $rating.empty? == true
					puts " "
					puts "You forgot to type the rating!"
				else
					if $rating.to_i.to_s != $rating
						puts " "
						puts "You did not enter a number!"
					else	
						if $rating.to_i.to_s == $rating
							if ($bottomrating.to_i..$toprating.to_i) === $rating.to_i
								break
							else
								puts " "
								puts "You did not type a number between #{$bottomrating} and #{$toprating}!"
							end
						end
							
					end
				end
			end
		end
		#Complete
		if $artist.downcase != "back to main menu" or $album.downcase != "back to main menu" or $rating.downcase != "back to main menu"
			loop do
				puts " "
				puts "Comments? "
				puts "(Please type 'back to main menu' to exit.)"
				puts " "
				$comment = gets.chomp
				if $comment.empty? == true
					puts " "
					puts "No comments? OK!"
					$comment = "No comments"
					break
				else
					break
				end
			end
		end
		#Complete
		if $artist.downcase != "back to main menu" or $album.downcase != "back to main menu" or $rating.downcase != "back to main menu" or $comment.downcase != "back to main menu"	
			$list.insert($currentartist,"Album: #{$album}","Rating: #{$rating}","Comments: #{$comment}")
			puts " "
			puts "#{$album} added!"
			loop do
				puts " "
				puts "Do you want to add another album for #{$artist}? "
				puts " "
				$fifthchoice = gets.chomp.capitalize
				if $fifthchoice == "Yes" or $fifthchoice == "No" or $fifthchoice == "Exit" 
					break
				else
					puts " "
					puts "Enter valid choice"
				end
			end
		end
		#Complete
	end
	#Complete
end
#Complete

# Update Artist or Album?

def updatemenu
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "Would you like to update an 'Artist' or an 'Album'? "
			puts " "
			$tenthchoice = gets.chomp.capitalize
			if $tenthchoice == "Artist" or $tenthchoice == "Album" or $tenthchoice == "Exit"
				break
			elsif $tenthchoice.empty? == true
				puts " "
				puts "You forgot to type an option!"
			else
				puts " "
				puts "Enter valid choice."
			end
		end
	end
end
#Complete

# Update Artist name

def updateartist
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "Which Artist do you want to update? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$artist = gets.chomp
			if $artist.empty? == true
				puts " "
				puts "You forgot to type the artists name!"
			else
				if $list.index("Artist: #{$artist}") != nil
					break
				else
					puts " "
					puts "This artist does not exist! "
				end
			end			
		end
		#Complete
		if $artist.downcase != "back to main menu"
			$currentartist = $list.index("Artist: #{$artist}")
			loop do
				puts " "
				puts "What do you want to update #{$artist} to? "
				puts " "
				$updateartist = gets.chomp
				if $updateartist.empty? == true
					puts " "
					puts "You forgot to type the artists new name!"
				else
					if $updateartist.downcase != "back to main menu"
						$list.delete_at($currentartist)
						$list.insert($currentartist,"Artist: #{$updateartist}")
						puts " "
						puts "#{$artist} updated to #{$updateartist}!"
						break
					end
				end
			end
		end			
	end
end
#Complete

# Update Album details

def updatealbum
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	elsif $list.index{|i| i.to_s.include?("Album: ")} == nil
		puts " "
		puts "You haven't added any albums yet!"
	else
		loop do
			puts " "
			puts "Which Album do you want to update? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$album = gets.chomp
			if $album.empty? == true
				puts " "
				puts "You forgot to type the albums name!"
			else
				if $list.index("Album: #{$album}") != nil
					break
				else
					puts " "
					puts "This album does not exist! "
				end		
			end
		end
		#Complete
		if $album.downcase != "back to main menu"
			$currentalbum = $list.index("Album: #{$album}")
			loop do
				puts " "
				puts "Do you want to update the name for #{$album}?"
				puts " "
				$updatename = gets.chomp.capitalize
				if $updatename == "Yes" or $updatename == "Exit" 
					break
				elsif $updatename == "No" 
					$updatename = "#{$album}"
					break
				else
					puts " "
					puts "Enter valid choice."
				end
			end
			#Complete
			if $updatename == "Yes"
				loop do
					puts " "
					puts "What do you want to update #{$album} to? "
					puts " "
					$updatename = gets.chomp
					if $updatename.empty? == true
						puts " "
						puts "You forgot to type the albums new name!"
					else
						$list.delete_at($currentalbum)
						$list.insert($currentalbum,"Album: #{$updatename}")
						puts " "
						puts "#{$album} updated to #{$updatename}!"
						break
					end
		
				end
			else
				$updatename = "#{$album}"
			end
			#Complete
			if $updatename.downcase != "back to main menu" or $updatename == "#{album}" or $updatename == "Yes"
				loop do
					if $list[$currentalbum].to_s.include?("Rating: ") == true or $list[$currentalbum] == nil
						break
					else
						$currentalbum += 1
					end
				end
				#Complete
				loop do
					puts " "
					puts "Do you want to update the rating for #{$updatename}? (Current #{$list[$currentalbum]})"
					puts " "
					$updaterating = gets.chomp.capitalize
					if $updaterating == "Yes" or $updaterating == "Exit" 
						break
					elsif $updaterating == "No" 
						break
					else
						puts " "
						puts "Enter valid choice."
					end
				end
				#Complete
				if $updaterating == "Yes"
					loop do
						puts " "
						puts "What do you want to update the rating for #{$updatename} to? (from #{$bottomrating} to #{$toprating})"
						puts " "
						$updaterating = gets.chomp
						if $updaterating.empty? == true
							puts " "
							puts "You forgot to type the rating!"
						else
							if $updaterating.to_i.to_s != $updaterating
								puts " "
								puts "You did not enter a number!"
							else
								if $updaterating.to_i.to_s == $updaterating
									if ($bottomrating.to_i..$toprating.to_i) === $updaterating.to_i
										$list.delete_at($currentalbum)
										$list.insert($currentalbum,"Rating: #{$updaterating}")
										puts " "
										puts "#{$updatename} rating updated to #{$updaterating}!"
										break
									else
										puts " "
										puts "You did not type a number between #{$bottomrating} and #{$toprating}!"
									end
								end	
							end
						end
					end
				else
					$updaterating = ""
				end
				#Complete
				if $updaterating.downcase != "back to main menu" or $updaterating == "" or $updaterating == "Yes"
					loop do
						if $list[$currentalbum].to_s.include?("Comments: ") == true or $list[$currentalbum] == nil
							break
						else
							$currentalbum += 1
						end
					end
					#Complete
					loop do
						puts " "
						puts "Do you want to update the comment for #{$updatename}? (Current #{$list[$currentalbum]})"
						puts " "
						$updatecomment = gets.chomp.capitalize
						if $updatecomment == "Yes" or $updatecomment == "Exit" 
							break
						elsif $updatecomment == "No" 
							$updatename = "#{$album}"
							break
						else
							puts " "
							puts "Enter valid choice."
						end
					end
					#Complete
					if $updatecomment == "Yes"
						loop do
							puts " "
							puts "What do you want to update the comment for #{$updatename} to? "
							puts " "
							$updatecomment = gets.chomp
							if $updatecomment.downcase == "back to main menu"
								break
							end
							if $updatecomment.empty? == true
								puts " "
								puts "No comments? OK!"
								$updatecomment = "No comments"
								$list.delete_at($currentalbum)
								$list.insert($currentalbum,"Comments: #{$updatecomment}")
								puts " "
								puts "#{$updatename} comment updated to #{$updatecomment}!"
								break
							else
								$list.delete_at($currentalbum)
								$list.insert($currentalbum,"Comments: #{$updatecomment}")
								puts " "
								puts "#{$updatename} comment updated to #{$updatecomment}!"
								break
							end
						end	
					end
					#Complete
				end
				#Complete
			end
			#Complete
		end
		#Complete
	end
	#Complete
end
#Complete

# Delete Artist or Album?

def deletemenu
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "Would you like to delete an 'Artist' or an 'Album'? "
			puts " "
			$eighthchoice = gets.chomp.capitalize
			if $eighthchoice == "Artist" or $eighthchoice == "Album" or $eighthchoice == "Exit"
				break
			else
				puts " "
				puts "Enter valid choice."
			end
		end
	end
end

# Delete Artist and associated Albums

def deleteartist
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "Which Artist do you want to delete? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$artist = gets.chomp
			if $artist.empty? == true
				puts " "
				puts "You forgot to type the artists name!"
			else
				if $list.index("Artist: #{$artist}") != nil
					break
				else
					puts " "
					puts "This artist does not exist! "
				end	
			end
		end
		if $artist.downcase != "back to main menu"
			$currentartist = $list.index("Artist: #{$artist}")
			loop do
				puts " "
				puts "Are you sure you want to delete #{$artist} and any albums added for that artist? "
				puts " "
				$sixthchoice = gets.chomp.capitalize
				if $sixthchoice == "Yes" or $sixthchoice == "No" or $sixthchoice == "Exit" 
					break
				else
					puts " "
					puts "Enter valid choice"
				end
			end
			if $sixthchoice == "Yes"
				$list.delete_at($currentartist)
				loop do
					if $list[$currentartist].to_s.include?("Artist: ") == true or $list[$currentartist] == nil
						break
					else
						$list.delete_at($currentartist)
					end
				end
				puts " "
				puts "#{$artist} deleted!"
			end
		end
	end
end

# Delete Album

def deletealbum
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	elsif 	$list.index{|i| i.to_s.include?("Album: ")} == nil
		puts " "
		puts "You haven't added any albums yet!"
	else
		loop do
			puts " "
			puts "Which Album do you want to delete? "
			puts "(Please type 'back to main menu' to exit.)"
			puts " "
			$album = gets.chomp
			if $album.empty? == true
				puts " "
				puts "You forgot to type the albums name!"
			else
				if $list.index("Album: #{$album}") != nil
					break
				else
					puts " "
					puts "This album does not exist! "
				end
			end	
		end
		if $album.downcase != "back to main menu"
			$currentalbum = $list.index("Album: #{$album}")
			loop do
				puts " "
				puts "Are you sure you want to delete #{$album}? "
				puts " "
				$ninthchoice = gets.chomp.capitalize
				if $ninthchoice == "Yes" or $ninthchoice == "No" or $ninthchoice == "Exit" 
					break
				else
					puts " "
					puts "Enter valid choice"
				end
			end
		end
		if $ninthchoice == "Yes"
			$list.delete_at($currentalbum)
			loop do
				if $list[$currentalbum].to_s.include?("Artist: ") == true or $list[$currentalbum].to_s.include?("Album: ") == true or$list[$currentalbum] == nil
					break
				else
					$list.delete_at($currentalbum)
				end	
			end
			puts " "
			puts "#{$album} deleted!"
		end				
	end
end

# Display Artists and Albums

def displayinfo
	if $list.none? == true
		puts " "
		puts "You haven't added any artists yet!"
	else
		loop do
			puts " "
			puts "What would you like to display?"
			puts "(Type 'all' to display all artists, albums and ratings or 'artist' for a specific artist.) "
			puts " "
			$seventhchoice = gets.chomp.capitalize
			if $seventhchoice == "All" or $seventhchoice == "Artist"or $seventhchoice == "Exit"
				break
			elsif $seventhchoice.empty? == true
				puts " "
				puts "You forgot to type an option!"
			else
				puts " "
				puts "Enter valid choice"
			end
		end
		if $seventhchoice == "All"
			if $list.none? == true
				puts " "
				puts "You haven't added any artists yet!"
			else	
				puts " "
				$list.each{|n| puts n}
			end
		elsif $seventhchoice == "Artist"
			if $list.none? == true
				puts " "
				puts "You haven't added any artists yet!"
			else
				loop do
					puts " "
					puts "Which artist do you want to display? "
					puts "(Please type 'back to main menu' to exit.)"
					puts " "
					$artist = gets.chomp
					if $artist.empty? == true
						puts " "
						puts "You forgot to type the artists name!"
					else
						if $list.index("Artist: #{$artist}") != nil
							break
						else
							puts " "
							puts "This artist does not exist! "
						end
					end	
				end
				if $artist.downcase != "back to main menu"
					$currentartist = $list.index("Artist: #{$artist}")
					puts " "
					puts $list[$currentartist]
					$currentartist += 1
					loop do
						if $list[$currentartist].to_s.include?("Artist: ") == true or $list[$currentartist] == nil
							break
						else
							puts $list[$currentartist]
							$currentartist += 1
						end
					end
				end
			end				
		end
	end
end

# Reset program

def resetloop
	$firstchoice = "nil"
	$secondchoice = "nil"
	$thirdchoice = "nil"
	$fourthchoice = "nil"
	$fifthchoice = "nil"
	$sixthchoice = "nil"
	$seventhchoice = "nil"
	$eighthchoice = "nil"
	$ninthchoice = "nil"
	$tenthchoice = "nil"
	$artist = "nil"
	$album = "nil"
	$rating = "nil"
	$comment = "nil"
	$updateartist = "nil"
	$updatename = "nil"
	$updaterating = "nil"
	$updatecomment = "nil"
	$currentartist = 0
	$currentalbum = 0
end


# Main Program

loop do
	resetloop

	mainmenu

	if $firstchoice == "Add"
		addmenu
	elsif $firstchoice == "Delete"
		deletemenu
	elsif $firstchoice == "Update"
		updatemenu
	elsif $firstchoice == "Display"
		displayinfo
	elsif $firstchoice == "Rating"
		setrating
	elsif $firstchoice == "Exit"
		resetloop
	elsif $firstchoice == "End"
		$list.insert(0,"#{$ratingset}")
		$list.insert(0,"#{$toprating}")
		$list.insert(0,"#{$bottomrating}")
		File.open("albumratings.txt", "r+") do |f|
  			$list.each { |element| f.puts(element) }
		end
		exit
	end

	if $secondchoice == "Artist"
		addartist
		if $artist.downcase != "back to main menu"	
			alsoaddalbummenu
		end

		if $thirdchoice == "Yes"
			alsoaddalbum
		elsif $thirdchoice == "Exit"
			resetloop
		end

		if $fourthchoice == "Yes"
			loop do
				alsoaddalbum
				if $fourthchoice == "No" 
					break
				elsif $fourthchoice == "Exit" 									
					resetloop
					break
				end
			end
		end

	elsif $secondchoice == "Album"
		whichartistaddalbum
		if $album.downcase != "back to main menu"
			addalbum
		end

		if $fifthchoice == "Yes"
			loop do
				addalbum
				if $fifthchoice == "No" 
					break
				elsif $fifthchoice == "Exit" 
					resetloop
				end
			end
		end
	elsif $secondchoice == "Exit"
		resetloop
	end
	
	if $eighthchoice == "Artist"
		deleteartist
	elsif $eighthchoice == "Album"
		deletealbum
	elsif $eighthchoice == "Exit"
		resetloop
	end

	if $tenthchoice == "Artist"
		updateartist
	elsif $tenthchoice == "Album"
		updatealbum
	elsif $tenthchoice == "Exit"
		resetloop
	end
	
	File.open("albumratings.txt", "r+") do |f|
  		$list.each { |element| f.puts(element) }
	end
end