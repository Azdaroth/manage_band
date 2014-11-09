require 'rails_helper'

describe User::RegistrationForm do

  subject { User::RegistrationForm.new(User.new) }

  describe "#persist" do

    let(:valid_params) {
      {
        email: "email@example.com",
        password: "foobar123",
        password_confirmation: "foobar123",
        confirm_success_url: "http://google.pl",
        band_name: "Death Levels All"
      }
    }

    context "side effects" do

      it "creates user" do
        expect do
          subject.persist(valid_params)
        end.to change(User, :count).by(1)
      end

      it "creates band and assigns user to it" do
        expect do
          subject.persist(valid_params)
        end.to change(Band, :count).by(1)
        last_user = User.last
        expect(last_user.bands.count).to eq 1
        expect(last_user.bands.first.name).to eq "Death Levels All"
      end

    end

    context "return value" do

      it "returns true if form is valid" do
        expect(subject.persist(valid_params)).to eq true
      end

      it "returns false if form is invalid" do
        expect(subject.persist({})).to eq false
      end

    end

  end

end