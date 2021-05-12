require 'rails_helper'

RSpec.describe Event::Operation::Create do
  before_all do
    @user = create :user
  end
  let(:user) { @user }

  subject(:operation) { described_class.call(params: params, current_user: user) }

  describe '.call' do
    describe 'with valid params' do
      let(:params) { attributes_for :event }

      it { should be_success }
      it 'should creates new records' do
        expect { operation }
          .to change(Event, :count).by(1)
          .and change(UserEvent, :count).by(1)
      end

      it 'should assign attributes' do
        expect(operation[:model].status).to eq :open
        expect(operation[:model].description).to eq ''
        expect(operation[:model].name).to eq params[:name]
        expect(operation[:model].date.strftime('%F %H:%M')).to eq params[:date]
      end
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