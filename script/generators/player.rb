module SSU
  module Generators
    class PlayerGenerator < Templater::Generator
      desc %{Script to download OFX statements from a Financial Institution.\n\nUsage: script/generate player REVERSE-DNS-ID NAME [LOGIN-URL]\n\nExample: script/generate player com.example.bank "Example Bank & Trust" http://bank.example.com/login}

      def self.source_root
        File.join(File.dirname(__FILE__), 'player', 'templates')
      end

      first_argument :fid, :required => true
      second_argument :org, :required => true
      third_argument :login_url, :required => false

      def login_url
        get_argument(2) || 'http://www.google.com/'
      end

      def script_path
        fid.tr('.', '/')
      end

      template :main do |t|
        t.source = "main.js.erb"
        t.destination = "application/chrome/content/wesabe/fi-scripts/#{script_path}.js"
      end

      template :login do |t|
        t.source = "login.js.erb"
        t.destination = "application/chrome/content/wesabe/fi-scripts/#{script_path}/login.js"
      end

      template :accounts do |t|
        t.source = "accounts.js.erb"
        t.destination = "application/chrome/content/wesabe/fi-scripts/#{script_path}/accounts.js"
      end
    end
  end
end
