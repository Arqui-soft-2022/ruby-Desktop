require 'faraday'
require 'faraday/net_http'


class API
    @@base_url = "https://codeqr-generate2.herokuapp.com/"
    
    def check_connection
        response = Faraday.get(@@base_url)
        return response.status == 200 ? true : false
    end


    def register_user(username, password, email, name)
        
        url = @@base_url+"api/auth/register"

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

        url = @@base_url+"api/auth/login"

        form_data = {
            "username": username,
            "password": password
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body

    end # end loginUser 

    def generate_qr(web_url, user_id)

        url = @@base_url+"api/code/"

        form_data = {
            "url": web_url,
            "user": user_id
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body
    end 

    def historical_qr(id_user)

        url = @@base_url+'api/code/historial'

        form_data = {
            "user": id_user
        }.to_json

        headers = {"Content-Type": 'application/json'}

        return Faraday.post(url, form_data, headers).body
    end # end historicalQr
end # end class api