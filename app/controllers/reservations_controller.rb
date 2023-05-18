class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @reservations = Reservation.where(user_id: current_user.id).includes(:user).order("created_at DESC")
  end

  def new
    @user = current_user
    @reservation = Reservation.new
    @room = Room.find(params[:room_id])
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @user = current_user
    @room = Room.find(params[:reservation][:room_id])
    if @reservation.checkin_at. == nil
      redirect_to @room, alert:"開始日を入力してください" and return
    end
    if @reservation.checkout_at. == nil
      redirect_to @room, alert:"終了日を入力してください" and return
    end
    if @reservation.checkout_at < @reservation.checkin_at
      redirect_to @room, alert:"終了日は開始日以降の日付にしてください" and return
    end
    if @reservation.person_count == nil
      redirect_to @room, alert:"正しい人数を入力してください" and return
    end
    if @reservation.person_count <= 0
      redirect_to @room, alert:"正しい人数を入力してください" and return
    end
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @user = User.find_by(params[:reservation][:room_id])
    @reservation = Reservation.new(params.require(:reservation).permit(:checkin_at, :checkout_at, :person_count, :user_id, :room_id ,:created_at , :updated_at))
    
    if @reservation.save
      flash[:notice] = "予約に成功しました"
      redirect_to reservations_path (@reservation)
    else
      flash.now[:alert] = "予約に失敗しました"
      render "rooms/show"
    end
  end

  def edit
    @rooms = Room.all
    @reservation = Reservation.find(params[:id])
  end

  def update
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    flash[:notice] = "削除しました"
    redirect_to reservations_path
  end

  def reservation_params
    params.require(:reservation).permit(:checkin_at, :checkout_at, :person_count , :user_id, :room_id , :created_at , :updated_at)
  end
end
