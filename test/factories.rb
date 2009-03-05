
Factory.define :user do |f|
  f.first_name 'John'
  f.last_name  'Doe'
  f.language 'en'
  f.email 'john@don.com'
  f.login 'john@don.com'
  f.password 'john'
  f.password_confirmation 'john'
end

Factory.define :task do |f|
  f.description 'Small test'
  f.send_email 'false'
  f.urgent 'true'
  f.user_id '1'
  f.resubmit '0'
end