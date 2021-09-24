require 'rails_helper'

RSpec.describe "Users", type: :system, js: true do
  scenario 'Visit user list. Then create the user. Then update the user.' do
    visit users_path
    expect(page).to have_content 'Users'

    click_on 'New User'
    expect(page).to have_content 'New User'

    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Name', with: Faker::Name.name
    click_on 'Create User'
    expect(page).to have_content 'User was successfully created.'

    click_on 'Edit'
    expect(page).to have_content 'Editing User'

    fill_in 'Email', with: Faker::Internet.email
    fill_in 'Name', with: Faker::Name.name
    click_on 'Update User'
    expect(page).to have_content 'User was successfully updated.'

    # TODO: Do not Work
    # click_on 'Back'
    # click_on 'Destroy'
    # expect(page).to have_content 'User was successfully destroyed.'
  end
end
