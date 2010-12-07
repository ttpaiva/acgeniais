class ApplicationController < ActionController::Base
  layout nil
  
  protect_from_forgery
 
  private
 
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'cfonseca' && password == 'kxawtp#me'
    end
  end
  
  
end
