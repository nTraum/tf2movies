class Tf2ClassesController < ApplicationController
  def index
  end

  def moderate
    @tf2_classes = Tf2Class.all.page params[:page]
  end

  def new
    @tf2_class = Tf2Class.new
  end

  def create
    @tf2_class = Tf2Class.new(tf2_class_params)

    if @tf2_class.save
      redirect_to moderate_tf2_classes_path, :notice => "TF2 Class '#{@tf2_class.name}' has been created successfully!"
    else
      redirect_to new_tf2_class_path, :alert => @tf2_class.errors.full_messages.join(', ')
    end
  end

  def show
  end

  def edit
    @tf2_class = Tf2Class.find(params[:id])
  end

  def update
    @tf2_class = Tf2Class.find(params[:id])

    if @tf2_class.update(tf2_class_params)
      redirect_to moderate_tf2_classes_path, :notice => 'TF2 class updated.'
    else
      redirect_to moderate_tf2_classes_path, :alert => @tf2_class.errors.full.join(', ')
    end
  end

  def destroy
    @tf2_class = Tf2Class.find(params[:id]).destroy
    redirect_to moderate_tf2_classes_path, :notice => 'TF2 class deleted.'
  end

  def tf2_class_params
    params.require(:tf2_class).permit(:name)
  end
end
