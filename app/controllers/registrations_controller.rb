class RegistrationsController < DeviseTokenAuth::RegistrationsController

  # The code is mostly awful... but that's not my code, pasted from gem's code
  # but I need to extend it and don't want to mess further
  # refactored a bit
  def create
    @resource = setup_resource
    return confirm_success_url_param_missing unless confirm_success_url_param_missing?
    return email_already_taken if email_taken?

    form = User::RegistrationForm.new(@resource)

    # override email confirmation, must be sent manually from ctrl
    @resource.skip_confirmation_notification!
    if form.persist(sign_up_params)
      user = form.model
      if user.confirmed?
        # email auth has been bypassed, authenticate user
        store_token_data(user)
        authenticate_user
      else
        # user will require email authentication
        send_confirmation_instructions(user)
      end
      success_response(user)
    else
      resource_invalid(form.model)
    end
  end

  private

    def setup_resource
      resource = resource_class.new(sign_up_params.except(:band_name))
      resource.uid = sign_up_params[:email]
      resource.provider = "email"
      resource
    end

    def confirm_success_url_param_missing
      render json: {
          status: 'error',
          data:   @resource,
          errors: ["Missing `confirm_success_url` param."]
      }, status: 403
    end

    def confirm_success_url_param_missing?
      params[:confirm_success_url]
    end

    def email_taken?
      User.where(email: sign_up_params[:email]).exists?
    end

    def email_already_taken
      clean_up_passwords @resource
      render json: {
        status: 'error',
        data:   @resource,
        errors: ["An account already exists for #{@resource.email}"]
      }, status: 403
    end

    def send_confirmation_instructions(resource)
      resource.send_confirmation_instructions({
        client_config: params[:config_name],
        redirect_url: params[:confirm_success_url]
      })
    end

    def store_token_data(resource)
      client_id = SecureRandom.urlsafe_base64(nil, false)
      token     = SecureRandom.urlsafe_base64(nil, false)

      resource.tokens[client_id] = {
        token: BCrypt::Password.create(token),
        expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
      }

      resource.save!
    end

    def authenticate_user
      update_auth_header
    end

    def resource_invalid(resource)
      clean_up_passwords resource
      render json: {
        status: 'error',
        data:   resource,
        errors: resource.errors.to_hash.merge(full_messages: resource.errors.full_messages)
      }, status: 403
    end

    def success_response(resource)
      render json: {
        status: 'success',
        data:   resource.as_json
      }
    end

end