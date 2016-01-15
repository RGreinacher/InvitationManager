# InvitationManager
Invite and organize event guests.

## Create required users

The app requires at least one *Admin*. Create it using the rails console `rails c`:

    admin = Admin.new(email: 'admin@example.com')
    admin.password = '12345678'
    admin.save!

After that you can use your new generated admin to login (eg. `http://localhost:3000/admins/sign_in`).

## Emails

To make use of the built in email functionality, source the following keys to make your SMTP credentials available for the app:

    SMTP_ADDRESS=""
    SMTP_DOMAIN=""
    SMTP_PASSWORD=""
    SMTP_USERNAME=""

## Internationalization

The app uses German as it's default language but is almost completely internationalized. So it's easy to translate the english *i18n* keys to any language you want.
