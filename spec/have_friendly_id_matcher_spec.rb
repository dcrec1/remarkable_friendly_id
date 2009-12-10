require 'spec_helper'

describe 'have_friendly_id' do
  include ModelBuilder
  
  before(:each) do
    @subject = define_model :users, :login => :string do
      has_friendly_id :login
    end
  end
  
  describe 'messages' do
    it 'should contain a description' do
      @matcher = have_friendly_id(:login)
      @matcher.description.should == 'have a friendly id generated from its :login column'
    end
  end
  
  describe 'matchers' do
    it { should have_friendly_id :login }
  end
  
  describe 'macros' do
    should_have_friendly_id :login
  end
end

