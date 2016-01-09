json.array!(@guests) do |guest|
  json.extract! guest, :id, :name, :email, :participating, :companions, :emails_sent
  json.url guest_url(guest, format: :json)
end
