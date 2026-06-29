class CreateFeedbacks < ActiveRecord::Migration[7.1]
  def change
    create_table :feedbacks do |t|
      t.string  :category,           null: false
      t.text    :message,             null: false
      t.string  :email
      t.string  :screenshot_filename
      t.string  :screen
      t.string  :app_version
      t.string  :build_number
      t.string  :platform
      t.string  :os_version
      t.string  :locale
      t.string  :user_id
      t.string  :device_model

      t.timestamps
    end

    add_index :feedbacks, :category
    add_index :feedbacks, :created_at
  end
end
