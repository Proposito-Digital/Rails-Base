# frozen_string_literal: true
class GenericController < ApplicationController
  include Translations::TranslationFlashMessages
  before_action :set_model_class
  
  # GET /users
  # GET /users.json
  def index
    filter
    @instances
    render layout: "layouts/admin/application"
  end
  
  # GET /users/1
  # GET /users/1.json
  def show
    set_instance
    authorize @instance
  end
  
  # GET /users/new
  def new
    @instance = @model.new
    authorize @instance
  end

  # GET /users/1/edit
  def edit
    set_instance
    authorize @instance
  end
  
  # POST /users
  # POST /users.json
  def create
    @instance = @model.new(instance_params)
    authorize @instance
    if @instance.save
      redirect_to self.send(redirect_to_index), flash: { success: translate_flash('success') }
    else
      render :new
    end
  end
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    set_instance
    authorize @instance
    if @instance.update(instance_params)
      redirect_to self.send(redirect_to_instance), flash: { success: translate_flash('success') }
    else
      render :edit
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    filter
    set_instance
    authorize @instance
    if @instance.destroy
      redirect_to self.send(redirect_to_index), flash: { success: translate_flash('success') }
    else
      render :index
    end
  end
   
  protected

    # def update_resource(resource, params)
    #   resource.update_without_password(params)
    # end

    def underscore_model_class
      @instance.class.name.underscore.pluralize
    end

  private

    def redirect_to_index
      controller = params[:controller]
      namespace = controller.gsub("/","_")[6..]
      "#{namespace}_path"
    end

    def redirect_to_instance
      controller = params[:controller]
      namespace = controller.singularize.gsub("/","_")[6..]
      "#{namespace}_path"
    end

    def set_model_class
      @model = params[:controller].gsub("admin/","").classify.constantize
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = @model.find(params[:id])
    end

    def filter
      @instance ||= @model.new
      #todo change options array filter
      if policy_scope(@model).present? 
        @instances = policy_scope(@model)
          .left_joins(search_relations)
          .strainer(filter_fields, filter_params[:term])
          .paginate(page: filter_paginate_params, per_page: filter_paginate_per_page)
          .sort_for(filter_sort_column, filter_sort_direction)
          .preload(preload_relations)
          .distinct
      end
    end

    def default_param_required
      @model.to_s.underscore.sub("/", "_").to_sym
    end

    def default_params_permited
      [ ]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(default_param_required).permit(default_params_permited)
    end

    def filter_fields
      [ ]
    end

    def search_relations
      preload_relations
    end

    def preload_relations
      [ ]
    end

    def filter_params
      params.permit(:term, :page, :sort_column, :sort_direction)
    end

    def filter_sort_column
      return filter_params[:sort_column] || default_filter_sort_column 
    end

    def filter_sort_direction
      return filter_params[:sort_direction] || default_filter_sort_direction     
    end

    def default_filter_sort_column
      return "created_at"
    end

    def default_filter_sort_direction
      return "DESC"
    end

    def filter_paginate_per_page
      return filter_params[:per_page] || default_paginate_per_page
    end

    def filter_paginate_params
      return filter_params[:page] || default_paginate_params
    end

    def default_paginate_params
      return 1
    end

    def default_paginate_per_page
      return 10
    end
end
