require('pg')

class BladeRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'music_collection', host: 'localhost'})
      db.prepare("query", sql)
      results = db.exec_prepared("query", values)
    ensure
      db.close()
    end
    return results
  end

end
