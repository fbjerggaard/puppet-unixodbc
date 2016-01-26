require 'spec_helper'
describe 'unixodbc' do

  context 'with defaults for all parameters' do
    it { should contain_class('unixodbc') }
  end
end
