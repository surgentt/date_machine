require_relative '../spec_helper'

describe 'LikeDriver' do 
  let(:session_data) {LikeDriver.new("fakeSession")}

  context '#save_profile' do
    it 'saves a specific profile to the database' do
      session_data.profile = "user"
      current_count = Profile.all.count
      session_data.save_profile
      expect(Profile.all.count).to eq(current_count += 1)
    end
  end

  context '#save_profiles_to_db' do
    let(:test_profiles1) {["sweetthang","randomuser"]}
    it 'saves profiles to db' do
      session_data.profiles = test_profiles1
      session_data.save_profiles_to_db
      expect(Profile.all.count).to eq(2)
    end

    let(:test_profiles2) {["sweetthang","sweetthang"]} 
    it 'does not save duplicate profiles' do  
        session_data.profiles = test_profiles2
        session_data.save_profiles_to_db
        expect(Profile.all.count).to eq(1)
    end
  end
end