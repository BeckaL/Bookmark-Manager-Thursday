require 'bookmark'

describe '.all' do
  it 'returns a list of bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
    persisted_dat = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
    bookmarks = Bookmark.all
    expect(bookmarks.length).to eq 1
    expect(bookmarks.first).to be_a Bookmark
    expect(bookmarks.first.title).to eq 'Makers Academy'
    expect(bookmarks.first.url).to eq "http://www.makersacademy.com"
  end

end
