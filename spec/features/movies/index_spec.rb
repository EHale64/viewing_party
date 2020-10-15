require 'rails_helper'

RSpec.describe "Top Movies Page" do
  before :each do
    @user = User.create!(email: 'tony@stark.com', password: '1234')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "Top 40 rated movies", :vcr do
    visit top_movies_path

    expect(page).to have_button('Top 40 Movies')

    expect(page).to have_css('.movie', count: 40)

    within(first('.movie')) do
      expect(page).to have_css('.title')
      within('.title')  do
        expect(page).to have_link("Gabriel's Inferno Part II")
      end

      expect(page).to have_css('.vote_average')
      within('.vote_average')  do
        expect(page).to have_content("8.9")
      end
    end
  end

  it "Top 40 movies search by keyword", :vcr do
    visit discover_path

    fill_in :find_movies, with: 'Rush Hour'
    click_button 'Find Movies'
    expect(current_path).to eq movies_search_path
    expect(page).to have_css('.movie', count: 10)

    within(first('.movie')) do
      within('.title')  do
        expect(page).to have_link('Rush Hour')
      end

      within('.vote_average')  do
        expect(page).to have_content("6.9")
      end
    end
  end

  it "Top 40 movies search by keyword; edge case less than 40 results", :vcr do
    visit discover_path

    fill_in :find_movies, with: 'Forrest'
    click_button 'Find Movies'
    expect(current_path).to eq movies_search_path
    expect(page).to have_css('.movie', count: 16)

    within(first('.movie')) do
      within('.title')  do
        expect(page).to have_link("Forrest Gump")
      end

      within('.vote_average')  do
        expect(page).to have_content("8.5")
      end
    end
  end

  it "Top 40 movies search by keyword; edge case no results", :vcr do
    visit discover_path

    fill_in :find_movies, with: 'ghty'
    click_button 'Find Movies'
    expect(current_path).to eq movies_search_path
    expect(page).to have_css('.movie', count: 0)

    expect(page).to have_content("No Movies Match Your Search")
  end
end
