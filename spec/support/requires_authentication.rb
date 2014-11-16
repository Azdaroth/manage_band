shared_examples 'requires_authentication' do |actions|
  actions.each do |action|
    it 'requires authentication' do
      get action, { id: 1 }
      expected_result = { "errors" => ["Authorized users only."] }
      expect(parsed_response).to eq expected_result
    end
  end
end