class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show destroy ]
  before_action :set_participant, only: %i[ show  ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @is_room_admin = (session[:admin_token] == @room.admin_token)
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    if @room.save
      session[:admin_token] = @room.admin_token
      session[:participant_name] = params[:participant_name]
      redirect_to @room, notice: "Sala criada com sucesso!"
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: "Room was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_path, notice: "Room was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find_by!(slug: params[:slug])
    end

    def set_participant
      session[:participant_id] ||= SecureRandom.hex(16)
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :slug)
    end
end
