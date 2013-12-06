class FieldsController < ApplicationController

  before_action :set_field, only: [:edit, :update, :destroy]
  
  # including Exceptions module from the initializers
  include Exceptions
  # exception handling
  rescue_from ActiveRecord::StatementInvalid, with: :invalid_duplicate_field
  rescue_from Exceptions::ColumnNotEmpty, with: :drop_action_on_non_empty_field

  def new
    @field = Field.new
  end

  def create_collection
    field_params.each do |data|
      Field.create(data)
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Field succesfully created'}
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      # if @field.change_column_if_empty
      if @field.update(field_params)
        format.html { redirect_to :controller => 'admin', :action => 'fields', notice: 'Field was successfully updated.' }
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
        format.html { redirect_to :controller => 'admin', :action => 'fields', :notice => 'Field successfully removed' }
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
      @field = Field.find(params[:id])
    end

    def field_params
      params.require(:field)
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