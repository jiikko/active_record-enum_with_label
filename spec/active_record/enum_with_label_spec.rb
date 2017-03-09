require 'spec_helper'

describe ActiveRecord::EnumWithLabel do
  it 'has a version number' do
    expect(ActiveRecord::EnumWithLabel::VERSION).not_to be nil
  end

  describe '::enum_with_label' do
    context 'key, [value1, value2]' do
      it 'return list of labels' do
        expect(User.status_labels).to match_array([
          "有効", "ロック", "未アクティベート",
        ])
      end
      describe '#status_label' do
        it 'return value of label' do
          user = User.create!(status: :status_active)
          expect(user.status_label).to eq('有効')
        end
      end
      it 'enable ActiveRecord::enum' do
        user = User.create!(status: :status_active)
        expect(User.statuses.size).to eq(3)
        expect(User.status_active.size).to eq(1)
        expect(user.status_active?).to eq(true)
        expect(user.status).to eq('status_active')
      end
    end

    context 'key, [{ label: value1, value: value2 }]' do
      it 'return list of nested key' do
        expect(Issue.status_labels).to match_array([
          "不具合", "新機能", "質問",
        ])
        expect(Issue.status_values).to match_array([
          5, 10, 15,
        ])
        expect(Issue.status_icons).to match_array([
          :fire, '+1', :question_mark,
        ])
      end
      describe '#status_#{name}' do
        it 'return value of label' do
          user = Issue.create!(status: :status_bug)
          expect(user.status_label).to eq('不具合')
          expect(user.status_value).to eq(5)
          expect(user.status_icon).to eq(:fire)
        end
      end
      it 'enable ActiveRecord::enum' do
        user = Issue.create!(status: :status_bug)
        expect(Issue.statuses.size).to eq(3)
        expect(Issue.status_bug.size).to eq(1)
        expect(user.status_bug?).to eq(true)
        expect(user.status).to eq('status_bug')
      end
    end
  end
end
