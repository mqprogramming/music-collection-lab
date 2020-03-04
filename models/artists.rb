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
                      (name)
                      VALUES
                      ($1)
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

  def update()
    sql = "UPDATE artists SET (name) = ($1) WHERE id = $2"
    values= [@name, @id]
    BladeRunner.run(sql, values)
  end

  def delete()
    sql= "DELETE FROM artists WHERE id = $1"
    values= [@id]
    BladeRunner.run(sql, values)
  end

  def self.delete_all()
    sql= "DELETE FROM artists"
    BladeRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    BladeRunner.run(sql, values)
  end

end
