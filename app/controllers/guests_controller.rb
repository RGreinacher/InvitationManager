class GuestsController < ApplicationController
  before_action :authenticate_admin!, except: [:edit, :update]
  before_action :check_guest, only: [:edit, :update]
  before_action :set_guest, only: [:show, :edit, :update, :destroy]

  # GET /guests
  def index
    @participating_guests = Guest.where(participating: 3).order(:name)
    @not_sure_guests = Guest.where(participating: 2).order(:name)
    @turned_down_guests = Guest.where(participating: 1).order(:name)
    @undecided_guests = Guest.where('sign_in_count > 0 and participating = 0').order(:name)
    @never_logged_in_guests = Guest.where(sign_in_count: 0).order(:name)
  end

  # GET /guests/1
  def show
  end

  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests/1/edit
  def edit
    @present = Present.new
    @presents = Present.all.order('LOWER(description)')
  end

  # POST /guests
  def create
    @guest = Guest.new(guest_params)
    @guest.participating = :undecided
    @guest.companions = 0
    @guest.emails_sent = 0
    @guest.token = SecureRandom.hex
    @guest.password = SecureRandom.hex

    respond_to do |format|
      if @guest.save
        format.html { redirect_to guests_path, notice: t('flashes.messages.create-success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /guests/1
  def update
    respond_to do |format|
      pre_update_participating_state = @guest.participating

      # update guest information
      if @guest.update(guest_params)

        # send admin notification mail
        if pre_update_participating_state != guest_params[:participating]
          GuestNotifyMailer.admin_notify_mail(
            @guest.name,
            pre_update_participating_state,
            @guest.participating,
            Guest.first,
            (Guest.where(participating: 3).count + Guest.where(participating: 3).sum(:companions))
          ).deliver_later
        end

        format.html {
          redirect_to edit_guest_path(@guest), notice: t('flashes.messages.update-success')
        }

        format.json {
          render status: 200, text: '"accepted"'
        }
      else
        format.html {
          edit
          render :edit
        }

        format.json {
          render nothing: true, status: 400
        }
      end
    end
  end

  # GET /guests/:id/will_participate
  def will_participate
    @guest.participating
  end

  # GET /guests/:id/turn_down
  def turn_down

  end

  # GET /guests/:id/is_undecided
  def is_undecided

  end

  # GET /guests/prepare_email
  def prepare_email
    @guests = Guest.where(queued: true)
  end

  # PATCH /guests/send_emails
  def send_emails
    respond_to do |format|
      error_message = ''
      if send_emails_params[:email_subject].empty?
        error_message = t('guest.prepare-email.notices.empty-subject-error')
      elsif send_emails_params[:email_intro].empty?
        error_message = t('guest.prepare-email.notices.empty-intro-error')
      elsif send_emails_params[:email_outro].empty?
        error_message = t('guest.prepare-email.notices.empty-outro-error')
      end

      if !error_message.empty?
        format.html do
          redirect_to guests_prepare_email_path, alert: error_message
        end
      else
        Guest.where(queued: true).each do |guest|
          GuestNotifyMailer.guest_notify_mail(
            guest,
            send_emails_params[:email_subject],
            send_emails_params[:email_intro],
            send_emails_params[:email_outro]
          ).deliver_later

          guest.queued = false
          guest.emails_sent += 1
          guest.save!
        end

        format.html do
          render :emails_sent
        end
      end
    end
  end

  # PATCH /guests/enqueue/
  def enqueue
    if params.has_key? :enqueue_all_guests
      Guest.all.each do |guest|
        guest.queued = params[:enqueue_all_guests]
        guest.save!
      end
    else
      guest = Guest.find(params[:enqueue_guest].to_i)
      guest.queued ^= true
      guest.save!
    end

    render json: { success: true }, status: 200
  end

  # DELETE /guests/1
  def destroy
    @guest.destroy
    respond_to do |format|
      format.html { redirect_to guests_url, notice: t('flashes.messages.delete-success') }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_guest
    @guest = Guest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def guest_params
    params.require(:guest).permit(
      :name,
      :notice,
      :email,
      :participating,
      :companions,
      :emails_sent,
      :salutation,
      :enqueue_all_guests,
      :enqueue_guest
    )
  end

  def send_emails_params
    params.require(:email_form).permit(
      :email_subject,
      :email_intro,
      :email_outro
    )
  end
end
