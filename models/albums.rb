require_relative('../db/sql_runner')

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
                      (name)
                      VALUES
                      ($1)
                      RETURNING id"
    values = [@name]
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
    return Artist.new(artist)

  end

end
