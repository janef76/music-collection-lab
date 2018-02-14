require_relative ('../db/sql_runner.rb')

class Artist
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @name = options['name']
  end

  def save()
      sql = "INSERT INTO artists
      (
        name
        )
        VALUES
        (
          $1
        )
        RETURNING *;"
        values = [@name]
        result = SqlRunner.run(sql, values)
        @id = result[0]['id'].to_i
  end

  def Artist.all()
    sql = "SELECT * FROM artists;"
    artists  = SqlRunner.run(sql)
    return artists.map {|artist_hash| Artist.new(artist_hash)}
  end


end
