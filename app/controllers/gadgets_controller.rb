class GadgetsController < ApplicationController
  def show
    if signed_in?
      @gadget  = Gadget.find(params[:id])
      if @gadget.user_id == @current_user.id
        @pictures = @gadget.pictures
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @gadget }
        end
      else
        redirect_to signin_path
      end
    else
      redirect_to signin_path
    end
  end

  def new
    if signed_in?

      @gadget = Gadget.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @gadget }
      end
    end
  end

  def edit
    @gadget = Gadget.find(params[:id])
  end

  def create
    if signed_in?
      @gadget = Gadget.new(gadget_params)
      @gadget.user_id = @current_user.id
      respond_to do |format|
        if @gadget.save

          if params[:images]
            # The magic is here ;)
            params[:images].each { |image|
              @gadget.pictures.create(image: image)
            }
          end

          format.html { redirect_to @gadget, notice: 'Gadget was successfully created.' }
          format.json { render json: @gadget, status: :created, location: @gadget }
        else
          format.html { render action: "new" }
          format.json { render json: @gadget.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to signin_path
    end
  end
  def update
    if signed_in?

      @gadget = Gadget.find(params[:id])
      if @gadget.user_id == @current_user.id
        respond_to do |format|
          if @gadget.update_attributes(gadget_params)
            if params[:images]
              # The magic is here ;)
              params[:images].each { |image|
                @gadget.pictures.create(image: image)
              }
            end
            format.html { redirect_to @gadget, notice: 'Gadget was successfully updated.' }
            format.json { head :no_content }
          else
            format.html { render action: "edit" }
            format.json { render json: @gadget.errors, status: :unprocessable_entity }
          end
        end
      else
        redirect_to signin_path
      end
    else
      redirect_to signin_path
    end
  end

  def destroy
    if signed_in?
      @gadget = Gadget.find(params[:id])
      if @gadget.user_id == @current_user.id
        @gadget.destroy
        respond_to do |format|
          format.html { redirect_to user_path(@current_user.id) }
          format.json { head :no_content }
        end
      else
        redirect_to signin_path
      end
    else
      redirect_to signin_path
    end
  end

  def search
    if signed_in?
      query = params[:query]
      @gadget = Gadget.where("name LIKE '#{query}%'").where(user_id: @current_user.id).first
      if @gadget
        redirect_to gadget_path(@gadget)
      else
        redirect_to user_path(@current_user)
      end
    else
      redirect_to signin_path
    end
  end

  private

  def gadget_params
    params.require(:gadget).permit(:description,
                                    :name,
                                    :pictures
                                   )
  end

end
