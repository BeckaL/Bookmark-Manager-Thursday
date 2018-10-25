require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.create(url:, title:)
    result = Bookmark.add(url, title).first
    Bookmark.new(id: result['id'], url: result['url'], title: result['title'])
  end

  def self.all
    connection = connect_to_database
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map { |bookmark| Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) }
  end

  def self.add(url, title)
    connection = connect_to_database
    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
  end

  def self.connect_to_database
    return PG.connect :dbname => "bookmark_manager_test" if ENV['RACK_ENV'] == 'test'
    PG.connect :dbname => "bookmark_manager"
  end

  def self.view_titles
    connection = self.connect_to_database
    result = connection.exec("SELECT title FROM bookmarks;")
    result.map { |bookmark| bookmark['title'] }
  end

end
