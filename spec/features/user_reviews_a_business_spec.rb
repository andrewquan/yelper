require 'spec_helper'

feature "user reviews a business" do
  scenario "user views a business page and leaves a review" do
    chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: '/tmp/chipotle.jpg')
    starbucks = Business.create(name: "Starbucks", description: "Coffee chain.", image_url: '/tmp/starbucks.jpg')
    panda_express = Business.create(name: "Panda Express", description: "Chinese food.", image_url: '/tmp/panda_express.jpg')

    sign_in

    visit_business_page(chipotle)

    submit_review("Awesome food!")
  end

  def visit_business_page(business)
    find("a[href='/businesses/#{business.id}']").click
    expect(page).to have_content business.name
  end

  def submit_review(content)
    fill_in "review[content]", with: content
    click_button "Submit"
    expect(page).to have_content "Thanks for your review!"
  end
end