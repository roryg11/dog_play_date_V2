require "rails_helper"

RSpec.describe User, :type => :model do
  it "validates the user is not created without an email" do
    lindeman = User.create(
    first_name: "Andy",
    last_name: "Lindeman",
    password: "1234"
    )

    expect(lindeman.valid?).to eq(false)
  end

  it "validates the password is longer than 3 characters" do
    dog_lover = User.create(
      first_name: "Lucy",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: "94117",
      password: "dog",
      )

    expect(dog_lover.valid?).to eq(false)
  end

  it "validates the first name is longer than 1 character" do
    dog_lover = User.create(
      first_name: "L",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: "94117",
      password: "dogs",
      )

    expect(dog_lover.valid?).to eq(false)
  end

  it "validates that a user can own a dog" do
    dog_lover = User.create!(
      first_name: "Lucy",
      last_name: "van Pelt",
      email: "ohbrothercharliebrown@gmail.com",
      zipcode: "94117",
      password: "dogs1234",
      )
    lucys_dog = dog_lover.dogs.create!(
      name: "Snoopy",
      breed: "Cartoon",
      gender: "Male",
      age: 2
      )
    expect(dog_lover.dogs.length).to eq(1)
  end

  it "validates that a user can have a conversation" do
    lucy = User.create!(
    first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    charlie = User.create!(
    first_name: "Charlie",
    last_name: "Brown",
    email: "ilovesnoopy@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    lucys_conversation = Conversation.create!(
      sender_id: lucy.id,
      recipient_id: charlie.id,
     )

    expect(charlie.conversations.length).to eq(1)
  end

  it "only returns dogs belonging to users that have not blocked them or been blocked by them" do
    lucy = User.create!(
    first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    charlie = User.create!(
    first_name: "Charlie",
    last_name: "Brown",
    email: "ilovesnoopy@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )
    emma = User.create!(
    first_name: "Emma",
    last_name: "Stone",
    email: "Emma@Stone.com",
    zipcode: "94116",
    password: "dogs1234",
    )

    andrew = User.create!(
    first_name: "Andrew",
    last_name: "Garfield",
    email: "Andrew@Garfield.com",
    zipcode: "94114",
    password: "dogs1234",
    )

    emmas_blocked_user = Filter.create!(
      type: "BlockedUser",
      content: "#{charlie.id}",
      user_id: emma.id
    )

    lucys_blocked_user = Filter.create!(
      type: "BlockedUser",
      content: "#{emma.id}",
      user_id: lucy.id
    )

    expect(emma.unavailable_users).to eq([charlie.id, lucy.id])
  end

  it "only returns dogs belonging to users that have not blocked them or been blocked by them" do
    lucy = User.create!(
    first_name: "Lucy",
    last_name: "van Pelt",
    email: "ohbrothercharliebrown@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )

    lucys_dog = lucy.dogs.create!(
      name: "Snoopy",
      breed: "Cartoon",
      gender: "Male",
      age: '2'
    )

    charlie = User.create!(
    first_name: "Charlie",
    last_name: "Brown",
    email: "ilovesnoopy@gmail.com",
    zipcode: "94117",
    password: "dogs1234",
    )

    charlies_dog = charlie.dogs.create!(
      name: "Janet",
      breed: "Rotweiler",
      gender: "Female",
      age: "2"
    )

    emma = User.create!(
    first_name: "Emma",
    last_name: "Stone",
    email: "Emma@Stone.com",
    zipcode: "94116",
    password: "dogs1234",
    )

    andrew = User.create!(
    first_name: "Andrew",
    last_name: "Garfield",
    email: "Andrew@Garfield.com",
    zipcode: "94114",
    password: "dogs1234",
    )

    andrews_dog = andrew.dogs.create!(
      name: "George",
      breed: "Bouvier",
      gender: "Male",
      age: "2"
    )

    emmas_blocked_user = Filter.create!(
      type: "BlockedUser",
      content: "#{charlie.id}",
      user_id: emma.id
    )

    lucys_blocked_user = Filter.create!(
      type: "BlockedUser",
      content: "#{emma.id}",
      user_id: lucy.id
    )

    expect(emma.dogs_user_can_see).to eq([andrews_dog])
  end
end
