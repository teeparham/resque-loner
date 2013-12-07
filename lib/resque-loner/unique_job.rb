require 'digest/md5'

#
#  If you want your job to be unique, include this module in it. If you wish,
#  you can overwrite this implementation of redis_key to fit your needs
#
module Resque
  module Plugins
    module UniqueJob
      def self.included(base)
        base.extend         ClassMethods
        base.class_eval do
          base.send(:extend, Resque::Helpers)
        end
      end # self.included
      
      module ClassMethods
        #
        #  Payload is what Resque stored for this job along with the job's class name.
        #  On a Resque with no plugins installed, this is a hash containing :class and :args
        #
        def redis_key(payload)
          payload = decode(encode(payload)) # This is the cycle the data goes when being enqueued/dequeued
          job  = payload[:class] || payload["class"]
          args = (payload[:args]  || payload["args"])
          args.map! do |arg|
            arg.is_a?(Hash) ? arg.sort : arg
          end

          digest = Digest::MD5.hexdigest encode(:class => job, :args => args)
          digest
        end

        #
        # The default ttl of a locking key is -1, i.e. forever.  If for some reason you only
        # want the lock to be in place after a certain amount of time, just set a ttl (in
        # seconds) for your job.  For example:
        #
        # class FooJob
        #   include Resque::Plugins::UniqueJob
        #   @loner_ttl = 40
        #   end
        # end
        #
        def loner_ttl
          @loner_ttl || -1
        end

        #
        # The default ttl of a persisting key is 0, i.e. immediately deleted.
        # You can set loner_lock_after_execution_period if you want to block the execution
        # of the job for a certain amount of time (in seconds).  For example:
        #
        # class FooJob
        #   include Resque::Plugins::UniqueJob
        #   @loner_lock_after_execution_period = 40
        #   end
        # end
        #
        def loner_lock_after_execution_period
          @loner_lock_after_execution_period || 0
        end

      end # ClassMethods
    end
  end
end
