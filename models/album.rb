require_relative('../db/sql_runner.rb')


class Album
  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize (options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options ['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING *;"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def artists_in_album()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    result = SqlRunner.run(sql, values)
    artist_hash = result[0]
    return Artist.new(artist_hash)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE albums
    SET
    (
      title,
      genre,
      artist_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4
    ;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def find()
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    albums = results.map {|album| Album.new(album)}
  end

  def Album.all()
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map{|album_hash| Album.new(album_hash)}
  end

end
