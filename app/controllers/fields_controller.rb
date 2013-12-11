class FieldsController < ApplicationController

  before_action :set_field, only: [:edit, :update, :destroy]
  #as PATCH request is sent, if the field_type is changed, the options hash is to be emptied explicitly
  before_action :remove_options_if_params_empty, only: [:update]
  
  # including Exceptions module from the initializers
  #[FIXME] I don't think we need to include this module
  include Exceptions
  # exception handling
  #[FIXME] do not rescue ActiveRecord::StatementInvalid. This will catch all exceptions
  rescue_from ActiveRecord::StatementInvalid, with: :invalid_duplicate_field
  rescue_from Exceptions::ColumnNotEmpty, with: :drop_action_on_non_empty_field

  def new
    @field = Field.new
  end
  #[FIXME] For now, we can create only one field at a time.
  def create_collection
    field_collection_params.each do |data|
      Field.create(data)
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Field succesfully created'}
    end
  end

  def edit
  end

  def index
    @fields = Field.all
  end

  def update
    respond_to do |format|
      if @field.update(field_params)
        #[FIXME] notice is appearing in query string
        format.html { redirect_to :action => :index, notice: 'Field was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @field.destroy
      respond_to do |format|
        format.html { redirect_to :back, :notice => 'Field successfully removed' }
        format.json { head :no_content }
      end
    # else
    #   respond_to do |format|
    #     format.html { redirect_to :controller => 'admin', :action => 'fields', :notice => 'Field cannot be removed, records depend on this field' }
    #     format.json { head :no_content }
    #   end
    # end
    end
  end

  private
    def set_field
      #[FIXME] use find_by and check if field exists
      @field = Field.find(params[:id])
    end

    def field_collection_params
      params.require(:field)
    end

    def field_params
      #[FIXME] using permit! will allow user to update any attribute.
      params.require(:field).permit!
    end

    def remove_options_if_params_empty
      @field.options = nil if field_params["options"].blank?
    end

    def invalid_duplicate_field(exception)
      logger.error "Attempt to create a duplicate field"
      flash[:notice] = "Field with the same name already exists, Cannot create a duplicate field. "
      redirect_to :back
    end

    def drop_action_on_non_empty_field(exception)
      logger.error exception.message
      flash[:notice] = exception.message
      redirect_to :back 
    end
end