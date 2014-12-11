require 'rails_helper'

describe Api::V1::Band::TaskListsController do

	it_behaves_like 'requires_authentication', [:show, :index, :create, :update, :destroy]

end