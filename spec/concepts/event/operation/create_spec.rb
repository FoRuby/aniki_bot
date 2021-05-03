require 'rails_helper'

RSpec.describe Event::Operation::Create do
  let(:user) { create :user }
  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'valid params' do
      let(:params) { attributes_for :event }

      it { is_expected.to be_success }
      it { expect { operation }.to change(Event, :count).by(1) }
      it { expect { operation }.to change(UserEvent, :count).by(1) }
      it { expect(operation[:model].status).to eq :open }
      it { expect(operation[:model].description).to eq '' }
      it { expect(operation[:model].name).to eq params[:name] }
      it { expect(operation[:model].date.strftime('%F %H:%M')).to eq params[:date] }
    end

    describe 'invalid params' do
      describe 'empty event name' do
        let(:params) { { name: '', date: '2021-01-01 19:00' } }

        it { expect(operation_errors(operation)).to include 'Name must be filled' }
        it_behaves_like 'invalid create event operation'
      end

      describe 'invalid date format' do
        let(:params) { { name: 'test', date: '2021-26-04' } }

        it { expect(operation_errors(operation)).to include 'Date must be a time' }
        it_behaves_like 'invalid create event operation'
      end

      describe 'invalid past date' do
        let(:params) { attributes_for :event, :past }

        it { expect(operation_errors(operation)).to include 'Date must be in future' }
        it_behaves_like 'invalid create event operation'
      end
    end
  end
end