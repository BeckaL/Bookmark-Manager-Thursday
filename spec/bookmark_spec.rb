require 'bookmark'

describe '.all' do
  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
    bookmark = Bookmark.create(url: "http://www.thebrowser.com", title: "The Browser")
    persisted_dat = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    bookmarks = Bookmark.all
    expect(bookmarks.length).to eq 2
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq "http://www.makersacademy.com"
    expect(bookmarks[1].title).to eq 'The Browser'
  end

end

describe '.delete' do
  it 'deletes a bookmark' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
    bookmark = Bookmark.create(url: "http://www.thebrowser.com", title: "The Browser")
    persisted_dat = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    Bookmark.delete('Makers Academy')
    bookmarks = Bookmark.all
    expect(bookmarks.length).to eq 1
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.title).to eq 'The Browser'
    expect(bookmarks.first.url).to eq "http://www.thebrowser.com"
  end

  describe '.update' do
    it 'updates a bookmark' do
      Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      @bookmark = Bookmark.all.first
      Bookmark.update(@bookmark.id, "12 weeks of hard work", "http://www.makersacademy.com")
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.title).to eq '12 weeks of hard work'
      expect(bookmarks.first.url).to eq "http://www.makersacademy.com"
    end
  end
end
