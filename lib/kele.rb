require 'httparty'
require 'json'
require_relative './roadmap'
require_relative './messages'


class Kele
    include HTTParty
    include Roadmap
    include Messages
    base_uri 'https://www.bloc.io/api/v1/'

    
    def initialize(email, password)
        auth = { email: email, password: password }
        response = self.class.post('/sessions', body: auth)
        @auth_token = response["auth_token"]
    end
    
    def get_me
        response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
        JSON.parse(response.body)
    end
    
    def get_mentor_availability(mentor_id)
        response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token }) 
        JSON.parse(response.body)
    end
    
    def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
        enrollment_id = get_me["current_enrollment"]["id"]
        body = {
                checkpoint_id: checkpoint_id,
                assignment_branch: assignment_branch,
                assignment_commit_link: assignment_commit_link,
                comment: comment,
                enrollment_id: enrollment_id
                }
        
        response = self.class.post("/checkpoint_submissions", headers: {"authorization" => @auth_token}, body: body)
        JSON.parse(response.body)
    end
end