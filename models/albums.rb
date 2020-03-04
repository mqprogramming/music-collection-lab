require_relative('../db/sql_runner')
require_relative('artists')

class Albums

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize( options )
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums
                      (title, genre, artist_id)
                      VALUES
                      ($1, $2, $3)
                      RETURNING id"
    values = [@title, @genre, @artist_id]
    @id = BladeRunner.run(sql, values)[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = BladeRunner.run(sql)
    albums.map do |album|
      Album.new(album)
    end
  end

  def self.find_albums_by_artist(artist_id)

    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [artist_id]
    albums = BladeRunner.run(sql, values)
    albums.map do |album|
      Album.new(album)
    end

  end

  def find_artist()

    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist = BladeRunner.run(sql, values).first()
    return Artists.new(artist)

  end

  def update()
    sql = "UPDATE albums SET (
            title, genre, artist_id)
            = ($1, $2, $3)
            WHERE id = $4"
    values = [@title, @genre, @artist_id, @id]
    BladeRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM albums WHERE id= $1"
    values= [@id]
    BladeRunner.run(sql, values)
  end

  def self.delete_all()
    sql= "DELETE FROM albums"
    BladeRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [id]
    BladeRunner.run(sql, values)
  end

end
