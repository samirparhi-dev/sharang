using Dash

include("utils.jl")

app.callback(
    Output("page-content", "children"),
    Input("url", "pathname")
) do pathname
    if pathname == "#github-actions"
        data = fetch_json_data(url::String)
        return render_vulnerability_cards(data)
    else
        return html_div("Select a category from the side panel.")
    end
end
