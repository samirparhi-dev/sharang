import Pkg
Pkg.add(["HTTP", "JSON"])
using HTTP
using JSON

function start_oauth_flow()
    auth_code_url = "https://github.com/login/oauth/authorize?client_id=$(CLIENT_ID)&redirect_uri=$(REDIRECT_URI)&scope=repo"
    open(`open $auth_code_url`) # Opens the URL in the default browser
    println("Waiting for authorization...")

    # Here you should implement a mechanism to listen to the redirect_uri and capture the authorization code
    # This example assumes you have a web server running that captures the code and saves it in a file
    sleep(10) # Replace with actual waiting mechanism
    auth_code = read("auth_code.txt", String) |> strip

    token_resp = HTTP.post("https://github.com/login/oauth/access_token", [
        "client_id" => CLIENT_ID,
        "client_secret" => CLIENT_SECRET,
        "code" => auth_code,
        "redirect_uri" => REDIRECT_URI
    ])

    access_token = split(token_resp.body, "&")[1] |> split("=") |> last
    fetch_user_info(access_token)
end

function fetch_user_info(access_token)
    headers = Dict("Authorization" => "token $access_token")
    user_resp = HTTP.get("https://api.github.com/user", headers)
    user_info = JSON.parse(String(user_resp.body))
    user_info
end
