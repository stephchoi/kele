require 'httparty'
require 'json'

class Kele
    include HTTParty
    base_uri 'https://www.bloc.io/api/v1/'

    
    def initialize(email, password)
        auth = { email: email, password: password }
        response = self.class.post('/sessions', body: auth)
        @auth_token = response["auth_token"]
    end
    
end