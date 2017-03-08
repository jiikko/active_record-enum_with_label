require 'spec_helper'

describe ActiveRecord::EnumWithLabel do
  it 'has a version number' do
    expect(ActiveRecord::EnumWithLabel::VERSION).not_to be nil
  end

  describe '::enum_with_label' do
    context 'key: :value' do
      it 'be return list of labes' do
        expect(User.status_labels).to match_array([
          "有効", "ロック", "未アクティベート",
        ])
      end

      describe '#status_label' do
        it 'be return value of label' do
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

    context 'key: { label: :value }' do
    end

    context 'key: { label: :value, value: :value }' do
    end
  end
end
