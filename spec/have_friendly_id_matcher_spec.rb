require 'spec_helper'

describe 'have_friendly_id' do
  include ModelBuilder
  
  def define_matcher(column, options={})
    @model = define_model :users, :login => :string do
      has_friendly_id :login
    end

    have_friendly_id(column, options)
  end
  
  describe 'messages' do
    it 'should contain a description' do
      @matcher = define_matcher(:login)
      @matcher.description.should == 'have a friendly id generated from #login'
      
      @matcher.use_slug(true)
      @matcher.description.should == 'have a friendly id generated from #login using a slug'
    end
    
    it 'should set has_friendly_id? message' do
      @matcher = define_matcher(:login)
      @matcher.matches? define_model(:items)
      @matcher.failure_message.should == 'Expected Item to have a friendly id, but none was found (did you call the #has_friendly_id macro on your model?)'
    end
    
    it 'should set column_matches? message' do
      @matcher = define_matcher(:name)
      @matcher.matches? @model
      @matcher.failure_message.should == 'Expected User to generate its friendly id from #name, not from #login'
    end
    
    it 'should set use_slug_matches? message' do
      @matcher = define_matcher(:login, :use_slug => true)
      @matcher.matches? @model
      @matcher.failure_message.should == 'Expected User to generate its friendly id using a slug'
    end
  end
  
  before(:each) do
    @subject = define_model :pages, :title => :string do
      has_friendly_id :title, :use_slug => true
    end
  end
  
  describe 'matchers' do
    it { should have_friendly_id :title }
    it { should have_friendly_id :title, :use_slug => true }
  end
  
  describe 'macros' do
    should_have_friendly_id :title
    should_have_friendly_id :title, :use_slug => true
  end
end

