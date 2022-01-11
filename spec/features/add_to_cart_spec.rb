require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # Setup
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )


   end
  end

  scenario "The see incremented cart items counter" do

    visit root_path

    expect(page).to have_content('My Cart (0)')

    find('.product button.btn-primary', match: :first).click

    # commented out b/c it's for debugging only
    save_and_open_screenshot

    expect(page).to have_content('My Cart (1)')
  end


end