require 'rails_helper'

class DummylModelForEmail

  include ActiveModel::Validations

  attr_accessor :email

  validates :email, email: true

end


describe EmailValidator do

  let(:model) { DummylModelForEmail.new }

  it "validates email format" do

    valid_emails = %w[email@example.com name.surname@email.com
        e-mail@example.com]

    valid_emails.each do |email|
      model.email = email
      expect(model).to be_valid
    end

    invalid_emails = %w[email @email.com email.example.com
      email@example email@example.]

    invalid_emails.each do |email|
      model.email = email
      expect(model).not_to be_valid
    end

  end

end