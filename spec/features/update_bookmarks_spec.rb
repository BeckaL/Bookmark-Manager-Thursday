feature do

  scenario 'updates a bookmark' do
    add_bookmark
    click_on('View all')
    click_on('Update a bookmark')
    fill_in 'Bookmark to update', with: 'transport for london'
    click_on 'update'
    fill_in 'title', with: 'former workplace'
    click_on 'update'
    expect(page).to have_content 'Bookmark updated'
    click_on('View all')
    expect(page).not_to have_content 'transport for london'
    
    expect(page).to have_content 'former workplace'
  end

end
