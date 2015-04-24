testdir = File.dirname(__FILE__)
$LOAD_PATH.unshift testdir unless $LOAD_PATH.include?(testdir)

libdir = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift libdir unless $LOAD_PATH.include?(libdir)

require "rubygems"
require "has_secure_token"
require "minitest/autorun"
require "minitest/unit"

Dir["models/*.rb"].each {|file| require file }

  def assert_not_nil(exp, msg=nil)
        msg = message(msg) { "<#{mu_pp(exp)}> expected to not be nil" }
        assert(!exp.nil?, msg)
  end

DB_FILE = 'tmp/test_db'
FileUtils.mkdir_p File.dirname(DB_FILE)
FileUtils.rm_f DB_FILE

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => DB_FILE

load 'schema.rb'
