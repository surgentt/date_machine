require_relative '../spec_helper'

describe 'Profile' do 

  it 'inherits from ActiveRecord::Base' do
    expect(Profile.superclass).to eq(ActiveRecord::Base)
  end
end