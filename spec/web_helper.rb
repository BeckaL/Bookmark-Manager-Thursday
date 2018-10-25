def add_bookmark
  visit '/add_bookmarks'
  fill_in 'url', with: 'https://tfl.gov.uk'
  fill_in 'title', with: 'transport for london'
  click_on('add')
end
