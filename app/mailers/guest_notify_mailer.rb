class GuestNotifyMailer < ApplicationMailer
  def guest_notify_mail(guest, subject, prelink_content, postlink_content)
    @guest = guest
    @prelink_content = prelink_content
    @postlink_content = postlink_content

    mail(
      to: @guest.email,
      subject: subject,
      from: t('prepare-email.from-address-name')
    )
  end
end
