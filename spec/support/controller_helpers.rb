def parsed_response
  JSON.parse(response.body)
end

def stub_current_user(user)
  allow(controller).to receive(:authenticate_user!) { true }
  allow(controller).to receive(:current_user) { user }
end


