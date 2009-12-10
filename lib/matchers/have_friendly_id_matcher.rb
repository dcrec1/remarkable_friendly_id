module Remarkable
  module FriendlyId
    module Matchers
      class HaveFriendlyIdMatcher < Remarkable::ActiveRecord::Base
        arguments :column
        optionals :use_slug
        
        assertions :has_friendly_id?,
                   :column_matches?,
                   :uses_slug?
        
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
        
        def uses_slug?
          return true if @options[:use_slug].nil?
          @friendly_id_options[:use_slug] == @options[:use_slug]
        end
        
        def interpolation_options
          {:column        => @column.to_s,
           :actual_column => (@friendly_id_options[:column] if @friendly_id_options)}
        end
      end
      
      def have_friendly_id(*args)
        HaveFriendlyIdMatcher.new(*args).spec(self)
      end
    end
  end
end
