shared_examples 'requires_authentication' do |actions|
  actions.each do |action|
    it 'requires authentication' do
      get action, { id: 1, band_id: 1, asset_list_id: 1, asset_id: 1, task_list_id: 1, task_id: 1 }
      expected_result = { "errors" => ["Authorized users only."] }
      expect(parsed_response).to eq expected_result
    end
  end
end