require 'spec_helper'

feature "user adds a business" do
  scenario "user adds a new business" do
    sign_in

    visit_add_business_page

    fill_in "Business Name", with: "Starbucks"
    fill_in "Description", with: "Coffee shop."
    select "Coffee", from: "Choose an image"
    click_button "Register Business"
    expect(page).to have_content "You successfully added a business."
  end

  def visit_add_business_page
    find("a[href='/businesses/new']").click
    expect(page).to have_content "Add New Business"
  end
end