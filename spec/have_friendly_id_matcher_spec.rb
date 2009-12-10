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
      @matcher.description.should == 'have a friendly id generated from #login'
    end
    
    it 'should set has_friendly_id? message' do
      @matcher = have_friendly_id(:login)
      @matcher.matches? define_model(:items)
      @matcher.failure_message.should == 'Expected Item to have a friendly id, but none was found (did you call the #has_friendly_id macro on your model?)'
    end
    
    it 'should set column_matches? message' do
      @matcher = have_friendly_id(:name)
      @matcher.matches? @subject
      @matcher.failure_message.should == 'Expected User to generate its friendly id from #name, not from #login'
    end
  end
  
  describe 'matchers' do
    it { should have_friendly_id :login }
  end
  
  describe 'macros' do
    should_have_friendly_id :login
  end
end

