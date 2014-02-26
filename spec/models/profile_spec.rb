require_relative '../spec_helper'

describe 'Profile' do 

  let(:attributes) {{
      :username = 'test_user'
      :messanged? = false
      :match_score = 90
    }}

  it 'inherits from ActiveRecord::Base' do
    expect(Profile.superclass).to eq(ActiveRecord::Base)
  end
end