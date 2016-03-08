Fabricator(:user) do
  given_name { FFaker::Name.first_name }
  family_name { FFaker::Name.last_name }
  email do |attrs|
    FFaker::Internet.email("#{attrs[:given_name]} #{attrs[:family_name]}")
  end
end
