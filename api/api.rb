require 'faraday'
require 'faraday/net_http'

class API
    def check_connection
        response = Faraday.get 'https://codeqr-generate.herokuapp.com'
        return response.status == 200 ? true : false
    end


    def register_user(username, password, email, name)
        
        url = "https://codeqr-generate.herokuapp.com/api/auth/register"

        form_data = {
            "username": username,
            "password": username,
            "email": email,
            "name": name
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body
    end # end registerUser

    def login_user(username, password)

        url = "https://codeqr-generate.herokuapp.com/api/auth/login"

        form_data = {
            "username": username,
            "password": password
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body

    end # end loginUser 

    def generate_qr(web_url, user_id)

        url = "https://codeqr-generate.herokuapp.com/api/code/"

        form_data = {
            "url": web_url,
            "user": user_id
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body
    end 

    def historical_qr(id_user)

        url = 'https://codeqr-generate.herokuapp.com/api/code/historial'

        form_data = {
            "user": id_user
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body
    end # end historicalQr
end # end class api