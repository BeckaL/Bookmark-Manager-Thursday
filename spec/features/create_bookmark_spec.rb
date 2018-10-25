feature 'adding bookmarks' do

  before do
    add_bookmark
  end

  scenario 'user can add bookmark from browser and get confirmation' do
    expect(page).to have_content('Bookmark added')
  end

  scenario 'user can add bookmark from browser and view on bookmarks page' do
    click_on('View all')
    expect(page).to have_content('transport for london')
  end
  
end
