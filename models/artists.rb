require_relative('../db/sql_runner')

class Artists

  attr_accessor :name
  attr_reader :id

  def initialize( options )
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO artists
                      (title, genre, artist_id)
                      VALUES
                      ($1, $2, $3)
                      RETURNING id"
    values = [@name]
    @id = BladeRunner.run(sql, values)[0]['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM artist"
    artists = BladeRunner.run(sql)
    artists.map do |artist|
      Artist.new(artist)
    end
  end

end
