module Messages
   def get_messages(page = nil)
       body = {}
       body.merge!(page: page) if page
       response = self.class.get("/message_threads", headers: { "authorization" => @auth_token }, body: body )
       JSON.parse(response.body)
   end
   
   def create_message(sender, recipient_id, stripped_text, token = nil, subject = nil)
      body = {
               sender: sender,
               recipient_id: recipient_id,
               'stripped-text': stripped_text
               }
               
      body.merge!(token: token) if token
      body.merge!(subject: subject) if subject
      
      response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: body)
      response.body
      # JSON.parse(response.body)
   end
end