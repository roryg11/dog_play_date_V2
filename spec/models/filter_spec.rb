require 'rails_helper'

describe Filter, :type => :model do
  it "belongs to a User" do
    user = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678",
    )

    filter = Filter.create!(
      type: "Breed",
      user_id: user.id,
      content: "Springer Spaniel"
    )

    content= user.breeds.map do |breed|
      breed.content
    end

    expect(filter.user.full_name).to eq("Emma Stone")
    expect(content).to eq(["Springer Spaniel"])
  end

  it "filters through size and returns only dogs of one size" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )
    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )

    filter = Filter.create!(
      type: "Size",
      user_id: emma.id,
      content: "Small"
    )

    fido = Dog.create!(
      name: "Fido",
      breed: "Lab",
      age: "5",
      size: "Small",
      play: "Toy-Motivated",
      gender: "Male",
      personality: "Dominant",
      user_id: andrew.id
    )

    lucky = Dog.create!(
      name: "lucky",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: andrew.id
    )

    emmas_matches = emma.filters.map do |filter|
      (filter.filter(Dog.all)).map do |dog|
        dog.name
      end
    end

    expect(emmas_matches).to eq([["Fido"]])
  end

  it 'filters through size and gender' do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )
    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )

    filter = Filter.create!(
      type: "Size",
      user_id: emma.id,
      content: "Small"
    )

    filter_2 = Filter.create!(
      type: "Gender",
      user_id: emma.id,
      content: "Female"
    )

    fido = Dog.create!(
      name: "Fido",
      breed: "Lab",
      age: "5",
      size: "Small",
      play: "Toy-Motivated",
      gender: "Male",
      personality: "Dominant",
      user_id: andrew.id
    )

    lucky = Dog.create!(
      name: "lucky",
      breed: "shar pei",
      age: "2",
      size: "Medium",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: andrew.id
    )

    puddle = Dog.create!(
      name: "puddle",
      breed: "shar pei",
      age: "4",
      size: "Small",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: andrew.id
    )

    dogs = Dog.all
    emmas_matches = emma.filters.each do |filter|
      dogs = filter.filter(dogs)
    end


    expect(dogs.map {|dog| dog.name}).to eq(["puddle"])
  end

  it "blocks other users and only returns dogs not belonging to that user" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )

    penn = User.create!(
      first_name: "Penn",
      last_name: "Badgely",
      email: "Penn@badgely.com",
      zipcode: 94118,
      password: "12345678"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94118,
      password: "12345678"
    )

    filter = Filter.create!(
      type: "BlockedUser",
      user_id: emma.id,
      content: "#{penn.id}"
    )

    filter = Filter.create!(
      type: "Gender",
      user_id: emma.id,
      content: "Female"
    )

    fido = Dog.create!(
      name: "fido",
      breed: "Lab",
      age: "5",
      size: "Small",
      play: "Toy-Motivated",
      gender: "Male",
      personality: "Dominant",
      user_id: andrew.id
    )

    puddle = Dog.create!(
      name: "puddle",
      breed: "shar pei",
      age: "4",
      size: "Small",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: penn.id
    )

    lucky = Dog.create!(
      name: "lucky",
      breed: "french bull dog",
      age: "4",
      size: "Small",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: andrew.id
    )

    dogs = Dog.all

    emma.filters.each do |filter|
      dogs = filter.filter(dogs)
    end

    dogs = dogs.map {|dog| dog.name}

    expect(dogs).not_to include(["puddle"])
    expect(dogs).to eq(["lucky"])
  end

  it "filters dogs based on their users location" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )

    penn = User.create!(
      first_name: "Penn",
      last_name: "Badgely",
      email: "Penn@badgely.com",
      zipcode: 94114,
      password: "12345678"
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94123,
      password: "12345678"
    )

    filter = Filter.create!(
      type: "Zipcode",
      user_id: emma.id,
      content: 94118
    )

    puddle = Dog.create!(
      name: "puddle",
      breed: "shar pei",
      age: "4",
      size: "Small",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: penn.id,
      zipcode: penn.zipcode
    )

    lucky = Dog.create!(
      name: "lucky",
      breed: "french bull dog",
      age: "4",
      size: "Small",
      play: "Food-Motivated",
      gender: "Female",
      personality: "Submissive",
      user_id: andrew.id,
      zipcode: andrew.zipcode
    )

    dogs = Dog.all
    emma.filters.each do |filter|
      dogs = filter.filter(dogs)
    end

    dogs = dogs.map {|dog| dog.name}

    expect(dogs).to eq(["puddle"])
    expect(dogs).not_to eq(["lucky"])
  end

  it "validates that a user can only have one gender filter" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )

    gender_filter = Filter.create(
      type: "Gender",
      content: "Female",
      user_id: emma.id
    )

    gender_filter_2 = Filter.create(
      type: "Gender",
      content: "Male",
      user_id: emma.id
    )

    expect(emma.filters.where(type: "Gender").length).to eq(1)
    expect(gender_filter_2.valid?).to eq(false)
  end

  it "validates that a user can only have up to four personality filters" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )

    personality_filter = Filter.create!(
      type: "Personality",
      content: "Laid-Back",
      user_id: emma.id
    )

    personality_filter_2 = Filter.create!(
      type: "Personality",
      content: "Shy-Timid",
      user_id: emma.id
    )

    personality_filter_3 = Filter.create!(
      type: "Personality",
      content: "Adaptable",
      user_id: emma.id
    )

    personality_filter_4 = Filter.create!(
      type: "Personality",
      content: "Confident",
      user_id: emma.id
    )

    personality_filter_5 = Filter.create(
      type: "Personality",
      content: "Independent",
      user_id: emma.id
    )


    expect(emma.filters.where(type: "Personality").length).to eq(4)
    expect(personality_filter_5.valid?).to eq(false)
  end
  it "filters through personality inclusively" do
    emma = User.create!(
      first_name: "Emma",
      last_name: "Stone",
      email: "Emma@stone.com",
      zipcode: 94118,
      password: "12345678"
    )

    personality_filter = Filter.create!(
      type: "Personality",
      content: "Laid-Back",
      user_id: emma.id
    )

    personality_filter_2 = Filter.create!(
      type: "Personality",
      content: "Adaptable",
      user_id: emma.id
    )

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Garfield",
      email: "Andrew@Garfield.com",
      zipcode: 94123,
      password: "12345678"
    )

    puddle = Dog.create!(
      name: "puddle",
      breed: "shar pei",
      age: "4",
      size: "Small",
      play: "Fetch",
      gender: "Female",
      personality: "Laid-Back",
      user_id: andrew.id,
      zipcode: andrew.zipcode
    )

    lucky = Dog.create!(
      name: "lucky",
      breed: "french bull dog",
      age: "4",
      size: "Small",
      play: "Chase",
      gender: "Female",
      personality: "Adaptable",
      user_id: andrew.id,
      zipcode: andrew.zipcode
    )

    raisin = Dog.create!(
      name: "raisin",
      breed: "french bull dog",
      age: "4",
      size: "Small",
      play: "Chase",
      gender: "Female",
      personality: "Confident",
      user_id: andrew.id,
      zipcode: andrew.zipcode
    )

    dogs = Dog.all
    emma.filters.each do |filter|
      dogs = filter.filter(dogs)
    end

    dogs = dogs.map {|dog| dog.name}

    expect(dogs).to eq(["puddle", "lucky"])
    expect(dogs).not_to eq(["raisin"])
  end
end
