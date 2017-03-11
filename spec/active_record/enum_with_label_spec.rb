require 'spec_helper'

describe ActiveRecord::EnumWithLabel do
  it 'has a version number' do
    expect(ActiveRecord::EnumWithLabel::VERSION).not_to be nil
  end

  describe '::enum_with_label' do
    context 'key, [value1, value2]' do
      it 'return list of labels' do
        expect(User.alert_status_labels).to match_array([
          'なし', 'メール送信', '電話'
        ])
      end
      describe '#status_label' do
        it 'return value of label' do
          user = User.create!(alert_status: :alert_status_none)
          expect(user.alert_status_label).to eq('なし')
        end
      end
      it 'enable ActiveRecord::enum' do
        user = User.create!(alert_status: :alert_status_none)
        expect(User.alert_statuses.size).to eq(3)
        expect(User.alert_status_none.size).to eq(1)
        expect(user.alert_status_none?).to eq(true)
        expect(user.alert_status).to eq('alert_status_none')
      end
    end

    context 'key, [{ label: value1, value: value2 }]' do
      it 'return list of nested key' do
        expect(Issue.respond_to?(:status_values)).to eq(false)
        expect(Issue.status_labels).to match_array([
          "不具合", "新機能", "質問",
        ])
        expect(Issue.status_icons).to match_array([
          :fire, '+1', :question_mark,
        ])
      end
      describe '#status_#{name}' do
        it 'return value of label' do
          issue = Issue.create!(status: :status_bug)
          expect(issue.status_label).to eq('不具合')
          expect(issue.status_icon).to eq(:fire)
          expect(issue.status_before_type_cast).to eq(5)
          expect(issue.respond_to?(:status_value)).to eq(false)
        end
      end
      it 'enable ActiveRecord::enum' do
        issue = Issue.create!(status: :status_bug)
        expect(Issue.statuses.size).to eq(3)
        expect(Issue.status_bug.size).to eq(1)
        expect(issue.status_bug?).to eq(true)
        expect(issue.status).to eq('status_bug')
      end
    end
  end
end
