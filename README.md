# ActiveRecord::EnumWithLabel

`ActiveRecord::EnumWithLabel` adds label and more to `ActiveRecord::Base.enum`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_record-enum_with_label'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record-enum_with_label

## Usage
```ruby
class User < ActiveRecord::Base
  include ActiveRecord::EnumWithLabel

  enum_with_label :alert_status, {
    alert_status_none: 'なし',
    alert_status_mail_sent: 'メール送信',
    alert_status_telephoned: '電話',
  }
end

User.alert_status_labels # => ['なし', 'メール送信', '電話']
user = User.create(alert_status: :alert_status_none)
user.alert_status_label            # => 'なし'
user.alert_status_before_type_cast # => 0

```
```ruby
class Issue < ActiveRecord::Base
  include ActiveRecord::EnumWithLabel

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

issue = Issue.create!(status: :status_bug)
issue.status_label            # => '不具合'
issue.status_icon             # => :fire
issue.status_before_type_cast # => 5
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jiikko/active_record-enum_with_label.
