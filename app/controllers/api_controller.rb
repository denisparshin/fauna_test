class ApiController < ApplicationController
  respond_to :json

  load_and_authorize_resource except: [:create]

  #skip_before_action :verify_authenticity_token if Rails.env == "development"

  include SerializerApi
  include ControllerApi

  def index
    params[:scope] ||= :index
    if params[:showall]
      render json: { symbol_params_many => serialize_objects(loaded_resources(params[:scope]), serializer_name, {scope: params[:scope]})}
    else
      data = loaded_resources(params[:scope])
      params[:page] ||= 1
      count = data.count
      resources = data.page(params[:page]).per(ENV["PER_PAGE"])
      render json: {
        count: count,
        per: ENV["PER_PAGE"],
        page: params[:page],
        symbol_params_many => serialize_objects(resources, serializer_name, {scope: params[:scope]})
      }
    end
  end

  def show
    render json: {symbol_params_one => serialize_object(loaded_resource, serializer_name, {scope: :show})}
  end

  def destroy
    if loaded_resource.destroy
      render json: {id: params[:id]}
    else
      render_error
    end
  end

  def create
    resource = loaded_class.new permited_params
    if resource.save
      render json: {symbol_params_one => serialize_object(resource, serializer_name, {scope: :create})}
    else
      render_error
    end
  end

  def update
    if loaded_resource.update(resource_params)
      render json: {symbol_params_one => serialize_object(loaded_resource, serializer_name, {scope: :update})}
    else
      render_error
    end
  end

  private

  def render_error
    render json: {error: I18n.t("info.something_went_wrong") }
  end

  def resource_params
    params.require(symbol_params_one).permit(to_permit)
  end

end

