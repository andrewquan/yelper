require 'spec_helper'

describe User do
  it { should have_many(:reviews) }
  it { should have_secure_password }
  it { should validate_uniqueness_of(:email) }
end