#
module ControllerMacros
  def login_headhunter
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:headhunter]
      headhunter = FactoryBot.create(:headhunter)
      # headhunter.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in headhunter
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