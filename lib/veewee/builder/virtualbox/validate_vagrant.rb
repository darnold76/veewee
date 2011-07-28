module Veewee
  module Builder
    module Virtualbox

      def validate_vagrant(validate_options={})
        require 'cucumber'

        require 'cucumber/rspec/disable_option_parser'
        require 'cucumber/cli/main'

        ENV['veewee_user']=options[:user]
        feature_path=File.join(File.dirname(__FILE__),"..","..","..","..","validation","vagrant.feature")

        features=Array.new
        features[0]=feature_path


        begin
          # The dup is to keep ARGV intact, so that tools like ruby-debug can respawn.
          failure = Cucumber::Cli::Main.execute(features.dup)
          Kernel.exit(failure ? 1 : 0)
        rescue SystemExit => e
          Kernel.exit(e.status)
        rescue Exception => e
          STDERR.puts("#{e.message} (#{e.class})")
          STDERR.puts(e.backtrace.join("\n"))
          Kernel.exit(1)
        end

      end
      
    end #Module
  end #Module
end #Module