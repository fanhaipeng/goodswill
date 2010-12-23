require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  test "fields should not be blank" do
    news = News.new
    assert !news.valid?
    assert news.errors[:title].any?
    assert news.errors[:content].any?

    news = News.new(:title => 'any text', :content => 'any text')
    assert news.valid?
  end

  test "news should have many images" do
    news = News.new(:title => 'any text', :content => 'any text')
    assert news.valid?
    assert news.images 
  end
end
