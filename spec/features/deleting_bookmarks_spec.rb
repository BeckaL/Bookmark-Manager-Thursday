feature 'delete bookmarks' do

  before do
    add_bookmark
  end

  scenario 'add and then delete bookmark' do
    click_on('View all')
    click_on('Delete a bookmark')
    fill_in 'Bookmark to delete', with: 'transport for london'
    click_on 'delete'
    expect(page).to have_content 'Bookmark deleted'

    click_on('View all')
    expect(page).not_to have_content 'transport for london'
  end
end
