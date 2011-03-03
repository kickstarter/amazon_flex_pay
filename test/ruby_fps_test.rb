require File.dirname(__FILE__) + '/test_helper'

class RubyFPSTest < RubyFPS::Test
  should "generate a valid v2 signature" do
    # NOTE: I'm not sure of a supplied signature example that I can copy, so
    # I set this one up by making sure signatures were being accepted by
    # Amazon and then generating and saving my own example. Kinda backwards
    # but good enough for regression testing.
    assert_equal "Ro7iH0M+1hIR/SXGvT1kmF6Tg5uUKRSUd1AWaJHOcpE=", RubyFPS.signature('http://example.com/api', {:hello => 'world'})
  end

  should "create a sorted query string" do
    assert_equal "a=1&b=2&c=3&d=4&e=5", RubyFPS.query_string(:a => 1, :b => 2, :c => 3, :d => 4, :e => 5)
  end

  should "flatten nested hashes into a query string using periods" do
    assert_equal "a.a=1&a.b=2&b=3", RubyFPS.query_string(:b => 3, :a => {:a => 1, :b => 2})
  end

  should "percent-encode spaces and other characters for a query string" do
    assert_equal 'a=hello%20world%21', RubyFPS.query_string(:a => 'hello world!')
  end
end
