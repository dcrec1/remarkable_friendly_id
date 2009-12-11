module Remarkable
  module FriendlyId
    module Matchers
      class HaveFriendlyIdMatcher < Remarkable::ActiveRecord::Base
        arguments :method
        
        optional :use_slug
        optional :reserved, :splat => true
        optional :cache_column

        assertions :has_friendly_id?,
                   :method_matches?,
                   :use_slug_matches?,
                   :reserved_matches?,
                   :cache_column_matches?

        before_assert do
          if @subject.respond_to?(:friendly_id_options)
            @friendly_id_options = @subject.send(:friendly_id_options)
          end
        end

      protected

        def has_friendly_id?
          not @friendly_id_options.nil?
        end

        def method_matches?
          @friendly_id_options[:method] == @method
        end
        def use_slug_matches?
          return true if @options[:use_slug].nil?
          @friendly_id_options[:use_slug] == @options[:use_slug]
        end

        def reserved_matches?
          return true if @options[:reserved].nil?
          @friendly_id_options[:reserved] == @options[:reserved]
        end
        
        def cache_column_matches?
          return true if @options[:cache_column].nil?
          @friendly_id_options[:cache_column] == @options[:cache_column]
        end
        
        def interpolation_options
          result = {:method       => @method.to_s,
                    :cache_column => @options[:cache_column],
                    :reserved     => array_to_sentence(@options[:reserved] || [], true)}

          unless @friendly_id_options.nil?
            result.merge!({:actual_method       => @friendly_id_options[:method].to_s,
                           :actual_reserved     => @friendly_id_options[:reserved].inspect,
                           :actual_cache_column => @friendly_id_options[:cache_column].inspect})
          end
          
          result
        end
      end

      def have_friendly_id(*args)
        HaveFriendlyIdMatcher.new(*args).spec(self)
      end
    end
  end
end
