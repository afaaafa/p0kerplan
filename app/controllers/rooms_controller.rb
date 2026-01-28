class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show destroy join identify updated_data ]
  before_action :set_participant, only: %i[ show create join identify ]
  before_action :set_admin_token, only: %i[ create ]
  before_action :ensure_participant_name, only: %i[ show ]

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  def join
  end

  def identify
    if params[:participant_name].present?
      session[:participant_name] = params[:participant_name]

      redirect_to @room
    else
      flash[:alert] = "Please, type your name."
      render :join
    end
  end

  def check_slug
    @room = Room.find_by(slug: params[:slug])

    render json: { available: @room.blank? }
  end

  # GET /rooms/1 or /rooms/1.json
  def show
    @is_room_admin = (session[:admin_token] == @room.admin_token)
    @current_participant =
      @room.participants.find_or_create_by!(
          session_id: session[:participant_id]
      ) do |p|
        p.name = session[:participant_name]
      end
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
      redirect_to join_room_path(@room), notice: "Room created! Now, tell us your name."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    return unless room_admin?
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

    def set_admin_token
      session[:admin_token] ||= SecureRandom.hex(16)
    end

    def ensure_participant_name
      if session[:participant_name].blank?
        redirect_to join_room_path(@room.slug)
      end
    end

    def room_admin?
      session[:admin_token] == @room.admin_token
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :slug)
    end
end
