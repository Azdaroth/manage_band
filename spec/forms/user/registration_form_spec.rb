require 'rails_helper'

describe User::RegistrationForm do

  subject { User::RegistrationForm.new(User.new) }

  describe "#persist" do

    let(:params) {
      {
        email: "email@example.com",
        password: "foobar123",
        password_confirmation: "foobar123",
        confirm_success_url: "http://google.pl",
        band_name: "Death Levels All"
      }
    }

    context "validation" do

      before(:each) do
        Band.create(name: "Death Levels All")
      end

      it "adds error if user tries to join to other band" do
        subject.persist(params)
        expect(subject.errors.messages[:band_name]).to be_present
      end

    end

    context "side effects" do

      it "creates user" do
        expect do
          subject.persist(params)
        end.to change(User, :count).by(1)
      end

      it "creates band and assigns user to it" do
        expect do
          subject.persist(params)
        end.to change(Band, :count).by(1)
        last_user = User.last
        expect(last_user.bands.count).to eq 1
        expect(last_user.bands.first.name).to eq "Death Levels All"
      end

    end

    context "return value" do

      it "returns true if form is valid" do
        expect(subject.persist(params)).to eq true
      end

      it "returns false if form is invalid" do
        expect(subject.persist({})).to eq false
      end

    end

  end

end