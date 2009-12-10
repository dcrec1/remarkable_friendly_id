module Remarkable
  module FriendlyId
    module Matchers
      class HaveFriendlyIdMatcher < Remarkable::ActiveRecord::Base
        arguments :column
        assertions :has_friendly_id?,
                   :column_matches?
        
        before_assert do
          if @subject.respond_to?(:friendly_id_options)
            @friendly_id_options = @subject.send(:friendly_id_options)
          end
        end
        
      protected
      
        def has_friendly_id?
          not @friendly_id_options.nil?
        end
        
        def column_matches?
          @friendly_id_options[:column] == @column
        end
      end
      
      def have_friendly_id(*args)
        HaveFriendlyIdMatcher.new(*args).spec(self)
      end
    end
  end
end
