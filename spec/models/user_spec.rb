require "rails_helper"

RSpec.describe User, :type => :model do
  it "validates the user is not created without an email" do
    lindeman = User.create(first_name: "Andy", last_name: "Lindeman")

    p User.all
    expect(User.all.length).to eq(0)
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

    expect(User.all.length).to eq(0)
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

    expect(User.all.length).to eq(0)
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
end
