feature 'delete bookmarks' do
  scenario 'add and then delete bookmark' do
    visit '/add_bookmarks'
    fill_in 'url', with: 'www.tfl.gov.uk'
    fill_in 'title', with: 'transport for london'
    click_on('add')
    click_on('View all')
    click_on('Delete a bookmark')
    fill_in 'Bookmark to delete', with: 'transport for london'
    click_on 'delete'
    expect(page).to have_content 'Bookmark deleted'
    click_on('View all')
    expect(page).not_to have_content 'transport for london'
  end
end
