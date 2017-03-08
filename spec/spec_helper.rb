$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_record/enum_with_label'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new('/dev/null')
ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.integer :status, null: false
  end
end
ActiveRecord::Schema.define do
  create_table :issues, force: true do |t|
    t.integer :status, null: false
  end
end

class User < ActiveRecord::Base
  enum_with_label :status, {
      status_active: '有効',
      status_lock: 'ロック',
      status_non_activate: '未アクティベート',
  }
end

class Issue < ActiveRecord::Base
  enum_with_label :status, {
    status_bug: {
      label: '不具合', value: 5, icon: :fire
    },
    status_feature: {
     label: '新機能', value: 10, icon: '+1'
    },
    status_question: {
     label: '質問', value: 15, icon: 'question_mark'
    },
  }
end
