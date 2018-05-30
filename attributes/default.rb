# commmon attributes
default['host']['ipaddress'] = node['ipaddress']  # private ipaddress
default['host']['public_ipaddress'] = "52.56.92.6" # aws public ip

# mongodb attributes
default['mongodb']['port'] = '27017'

# elasticsearch attributes
default['elasticsearch']['port'] = '9200'

# graylog attributes
default['graylog']['password_secret'] = 'IVdOdVWO0ZOWoX8OhhoWNVum84rM0h4ipwZ6j1GOiK71ktdB1sfnNp61zxuKL6GEwmTRUe9UGdxQvjMy8DukjOmk1vQsq4X8' # pwgen -N 1 -s 96
default['graylog']['password_sha2'] = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918' # echo -n passwd | sha256sum
