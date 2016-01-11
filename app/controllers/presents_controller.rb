class PresentsController < ApplicationController
  before_action :set_present, only: [:destroy]
  before_action :set_guest, only: [:create, :destroy]

  # POST /presents
  def create
    @present = Present.new(present_params)

    respond_to do |format|
      if @present.save
        format.html { redirect_to edit_guest_path(@guest), notice: t('flashes.messages.present-create-success') }
      else
        format.html { redirect_to edit_guest_path(@guest), flash: { error: t('flashes.messages.present-unable-to-create') } }
      end
    end
  end

  # DELETE /presents/1
  def destroy
    @present.destroy if @present.guest == @guest
    respond_to do |format|
      format.html { redirect_to edit_guest_path(@guest), notice: t('flashes.messages.present-delete-success') }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_present
      @present = Present.find(params[:id])
    end

    def set_guest
      @guest = Guest.find(params[:present][:guest_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def present_params
      params.require(:present).permit(
        :description,
        :guest_id
      )
    end
end
