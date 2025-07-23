require 'spec_helper'

describe InfinumSetup do
  it 'all programs valid' do
    [:general, :rails, :design, :android, :ios, :pm, :javascript, :java].each do |team|
      InfinumSetup::Base.new(team: team).programs.each do |program|
        expect(program.valid?).to be_truthy
      end
    end
  end
end
