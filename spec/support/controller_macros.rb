#
module ControllerMacros
  require 'spec_helper'
  require 'rails_helper'
  #require_relative '../factories/headhunter'
  
  def login_headhunter
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:headhunter]
      @headhunter = Factory.create(:headhunter)
      # headhunter.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in @headhunter
    end
  end

  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      # headhunter.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
end