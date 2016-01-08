Fabricator(:business) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.paragraph(3) }
  image_url { ['/tmp/chipotle.jpg', '/tmp/starbucks.jpg', '/tmp/panda_express.jpg'].sample }
end