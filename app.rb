require 'message_media_messages.rb' # This gem contains all the logic for dealing with the MessageMedia Messages API
require 'pp' # This gem is for displaying 'pretty' JSON

def setup
  # The API credentials needed to access the Messages API
  auth_user_name = 'API_KEY'
  auth_password = 'API_SECRET'
  use_hmac = false # Change this to true if you are using HMAC keys

  # Instantiating the client
  client = MessageMediaMessages::MessageMediaMessagesClient.new(
      auth_user_name: auth_user_name,
      auth_password: auth_password,
      use_hmac: use_hmac
  )
  return client
end

def send_message
  # Setup authentication and instantiate client
  client = setup();

  # Creating the message structure
  messages = client.messages
  body_value = '{
     "messages":[
        {
           "content":"Appointment Reminder",
           "destination_number":"+61491570156",
           "metadata": {
            "name": "Ibrahim"
           },
           "delivery_report": "true",
           "callback_url": "https://www.mycallbackurl.com"
        }
     ]
  }';

  # Parsing the message body and converting it into a Ruby object
  body = JSON.parse(body_value);

  # Finally, sending the message
  result = messages.create_send_messages(body)

  # Displaying the response in the console
  pp result
end

# Function to check message status
def check_status
  # Setup authentication and instantiate client
  client = setup()
  messages = client.messages
  message_id = 'MESSAGE_ID'
  result = messages.get_message_status(message_id)
  pp result
end

# Function to check replies
def check_replies
  # Setup authentication and instantiate client
  client = setup()
  replies = client.replies
  result = replies.get_check_replies()
  pp result
end

# Function to check delivery reports
def check_delivery_reports
  # Setup authentication and instantiate client
  client = setup()
  deliveryReports = client.delivery_reports
  result = deliveryReports.get_check_delivery_reports()
  pp result
end

# Add your function calls over here
send_message
