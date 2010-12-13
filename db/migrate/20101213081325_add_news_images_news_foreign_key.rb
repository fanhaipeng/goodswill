class AddNewsImagesNewsForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE news_images
        ADD CONSTRAINT news_image_news_foreign_key
        FOREIGN KEY (news_id)
        REFERENCES news(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE news_images DROP FOREIGN KEY news_image_news_foreign_key
    }
  end
end
