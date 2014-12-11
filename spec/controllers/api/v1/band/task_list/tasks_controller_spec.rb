require 'rails_helper'


describe Api::V1::Band::TaskList::TasksController do

	it_behaves_like 'requires_authentication', [:show, :index, :create, :update, :destroy]

end