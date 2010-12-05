class AddJoinNewsImageForeignKey < ActiveRecord::Migration
  def self.up
    execute %{
      ALTER TABLE news_images 
        ADD CONSTRAINT join_news_image_foreign_key
        FOREIGN KEY (news_id)
        REFERENCES news(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }

    execute %{
      ALTER TABLE news_images 
        ADD CONSTRAINT join_image_news_foreign_key
        FOREIGN KEY (image_id)
        REFERENCES images(id)
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
    }
  end

  def self.down
    execute %{
      ALTER TABLE news_images DROP FOREIGN KEY join_news_image_foreign_key
    }

    execute %{
      ALTER TABLE news_images DROP FOREIGN KEY join_image_news_foreign_key
    }
  end
end
