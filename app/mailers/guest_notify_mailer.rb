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

  def admin_notify_mail(guest_name, previous_participation_state, new_participation_state, admin_guest, participants_count)
    @guest_name = guest_name
    @previous_participation_state = previous_participation_state
    @new_participation_state = new_participation_state
    @admin_guest = admin_guest
    @participants_count = participants_count

    mail(
      to: t('admin-notifications.email'),
      subject: t('admin-notifications.subject'),
      from: t('prepare-email.from-address-name')
    )
  end
end
