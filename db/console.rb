require_relative('../models/albums')
require_relative('../models/artists')
require('pry')

Albums.delete_all()
Artists.delete_all()

artist1 = Artists.new({"name"=>'The Shaggs'})
artist2 = Artists.new({"name"=>'Frank Zappa'})

artist1.save()
artist2.save()

album1 = Albums.new({'title'=> "Philosophy of the World", "genre"=>'Genius', "artist_id"=>artist1.id})
album2 = Albums.new({'title'=>"Chunga's Revenge", "genre"=>'Psychadelic Freakout', "artist_id"=> artist2.id})

album1.save()
album2.save()

#binding.pry()
album1.genre = 'Super Genius'
album1.update()

# album2.delete()

binding.pry()
nil
