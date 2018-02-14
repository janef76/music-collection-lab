require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')

artist1 = Artist.new({ 'name' => 'air'})
artist2 = Artist.new({ 'name' => 'pink floyd'})

artist1.save()
artist2.save()

album1 = Album.new({
  'title' => 'Moon safari',
  'genre' => 'chill out',
  'artist_id' => artist1.id})

album2 = Album.new({
  'title' => 'Dark side of the moon',
  'genre' => 'rock',
  'artist_id' => artist2.id})

album1.save()
album2.save()

binding.pry

nil
