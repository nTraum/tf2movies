class Tf2ClassesController < ApplicationController
  after_action :verify_authorized, :except => [:index, :show]

  def index
  end

  def manage
    @tf2_classes = Tf2Class.all.page params[:page]
    authorize @tf2_classes
  end

  def new
    @tf2_class = Tf2Class.new
    authorize @tf2_class
  end

  def create
    @tf2_class = Tf2Class.new(tf2_class_params)
    authorize @tf2_class
    if @tf2_class.save
      redirect_to manage_tf2_classes_path, :notice => "TF2 Class '#{@tf2_class.name}' has been created successfully!"
    else
      redirect_to new_tf2_class_path, :alert => @tf2_class.errors.full_messages.join(', ')
    end
  end

  def show
    @tf2_class = Tf2Class.friendly.find(params[:id])
  end

  def edit
    @tf2_class = Tf2Class.friendly.find(params[:id])
    authorize @tf2_class
  end

  def update
    @tf2_class = Tf2Class.friendly.find(params[:id])
    authorize @tf2_class

    if @tf2_class.update(tf2_class_params)
      redirect_to manage_tf2_classes_path, :notice => 'TF2 class updated.'
    else
      redirect_to manage_tf2_classes_path, :alert => @tf2_class.errors.full_messages.join(', ')
    end
  end

  def destroy
    @tf2_class = Tf2Class.friendly.find(params[:id])
    authorize @tf2_class
    @tf2_class.destroy
    redirect_to manage_tf2_classes_path, :notice => 'TF2 class deleted.'
  end

  def tf2_class_params
    params.require(:tf2_class).permit(:name)
  end
end
