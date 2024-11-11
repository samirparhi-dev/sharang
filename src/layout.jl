import Pkg
Pkg.add(["Dash"])
Pkg.add(["TOML"])
# Pkg.add("DashBootstrapComponents")

using Dash
using TOML
# using DashBootstrapComponents

function generate_slug(text)
    # Convert to lowercase
    slug = lowercase(text)
    
    # Replace spaces with hyphens
    slug = replace(slug, " " => "-")
    
    # Remove any special characters (if necessary)
    slug = replace(slug, r"[^a-z0-9\-]" => "")
    
    return slug
end

function create_layout()
    html_div([
        
    html_div([
        html_div([
            html_img(src="https://raw.githubusercontent.com/samirparhi-dev/samirparhi-dev/main//Logos/Sharang.svg", style=Dict(
                 "height" => "130px",
                "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                "width" => "130px",
                "padding-left" => "20px",
                "cursor" => "pointer",
                # "flexGrow" => "1"
            )),
            html_div(
            html_p("The Productivity App (SysAdmin's)", style=Dict(
                    "borderRadius" => "10px",
                    "textAlign" => "center",
                    "marginBottom" => "8px",
                    "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                    "backgroundColor" => "#f9f9f9",
                    "display" => "flex",
                    "color" => "purple",
                    "fontSize" => "30px",
                    "flex-wrap" => "wrap"
                    ))),
            html_div([
                dcc_link(
                    html_button("↩", style=Dict(
                            "padding" => "10px 20px",
                            "fontSize" => "15px",
                            "cursor" => "pointer",
                            "background" => "rgba(255, 255, 255, 0.2)",
                            "backdropFilter" => "blur(10px)",
                            "border" => "2px solid black",
                            "border-radius" => "10px",
                            "boxShadow" => "0 4px 30px rgba(0, 0, 0, 0.1)",
                            "color" => "black",
                            "transition" => "0.3s",
                        )),
                        href="/",
                        style=Dict("marginRight" => "10px", "display" => "flex")
                    ),
                html_img(src="https://avatars.githubusercontent.com/u/59992800?v=4", style=Dict(
                    "width" => "40px",
                    "height" => "40px",
                    "borderRadius" => "50%",
                    "cursor" => "pointer",
                    "border" => "2px solid black",
                    "border-radius" => "10px"
                )),
            ], style=Dict(
                "display" => "flex",
                "alignItems" => "center"
            )),], style=Dict(
                        "display" => "flex",
                        "justifyContent" => "space-between",
                        "background" => "rgba(230, 230, 250, 0.2)",
                        "backdropFilter" => "blur(10px)",
                        "alignItems" => "center",
                        "width" => "100%",
                        "borderRadius" => "10px",
                        "boxShadow" => "0 4px 30px rgba(0, 0, 0, 0.1)",
                        "paddingRight" => "20px",
                        "transition" => "0.3s",
                        "border" => "2px solid black",
                        "border-radius" => "10px"
                        )),
    ])    
        
        html_div([
            dcc_location(id="url"),
            html_div(
                menu_bar,
                style=Dict(
                    "flex-direction" => "column",
                    # "height" => "auto",
                    "overflow-y" => "auto",
                    "display" => "flex",
                    "flex-wrap" => "wrap", 
                    "min-width" => "200px",
                    # "width" => "auto",
                    "margin-bottom" => "10px",
                    "background"=> "white",
                    "border" => "2px solid black",
                    "border-radius" => "10px",
                    "padding" => "2px"

                )
            ),
            html_div(id="page-content", 
                style=Dict(
                    "flex-grow" => "1",
                    "padding" => "30px",
                    "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                    "fontSize" => "20px",
                    "color" => "darkblue" 
                )
            )
        ], style=Dict(
            "display" => "flex",
            # "padding-top" => "20px",
            "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
            "backgroundColor" => "#f9f9f9",
            "padding-left" => "15px",
            "padding-top" => "5px"
        ))

    html_div([
            html_p("Built with ❤️ by :>",style=Dict("fontSize" => "15px","color" => "purple") )
            html_div([
                dcc_link(
                    html_p("samirparhi-dev ", style=Dict("fontSize" => "20px")),
                    href="https://github.com/samirparhi-dev",
                    target="_blank"  # This attribute opens the link in a new tab
                )],
                style=Dict(
                    "justify-content" => "center",
                    "textAlign" => "center",
                    "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                    
                )
            )], style=Dict(
                        "display" => "flex",
                        "justify-content" => "center",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "background" => "rgba(230, 230, 250, 0.2)",
                        "backdropFilter" => "blur(10px)",
                        "border" => "1px solid rgba(230, 230, 250, 0.3)",
                        "alignItems" => "center",
                        "borderRadius" => "10px",
                        "boxShadow" => "0 4px 30px rgba(0, 0, 0, 0.1)",
                        "transition" => "0.3s",
                        "alignItems" => "center",
                        ))
    ]) 
end

app = dash()
app.title = "Sharang"
Clustername = "UniCorn-Sx"
Kubernetes_version="1.30.1"
clusterNodes="6"
pod="21"
monitoring="Enabled"
ServiceMesh="Diasabled"
K8s_tracing="Disabled"
missconfig_critical= 2
missconfig_high= 5

sideBarMenuItem = TOML.parsefile("Uiconfig.toml")["sidebar_menu"]

base_urls = Dict(item => "/" * generate_slug(item) for item in sideBarMenuItem)

# println(base_urls)
menu_bar = [
    dcc_link(
        html_button(
            item, 
            id=item,
            style=Dict(
                "padding" => "10px",
                "fontSize" => "15px",
                "overflow-y" => "auto",
                "justify-content" => "left",
                "width" => "100%",
                "cursor" => "pointer",
                "background" => "rgba(255, 255, 255, 0.2)",
                "backdropFilter" => "blur(10px)",
                "border" => "1px solid rgba(255, 255, 255, 0.3)",
                "borderRadius" => "10px",
                "boxShadow" => "0 4px 30px rgba(0, 0, 0, 0.1)",
                "color" => "black",
                "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                "transition" => "0.3s"
            )
        ),
        href=base_urls[item],
        style=Dict(
            "display" => "flex",
            "overflow-y" => "auto",
            "justify-content" => "left",
            "flex-wrap" => "wrap",
            "background" => "white",
            "textDecoration" => "none",
            "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
            "color" => "purple"
        )
    )
    for item in sideBarMenuItem
]



# println(menu_bar)
app.layout = html_div() do 
    create_layout()
end


callback!(app,
    Output("page-content", "children"),
    Input("url", "pathname")
) do path
    if path == "/" || path == ""
        # Default content for the root path
        return html_div([
                html_div([
                    # Create a card-like div
                    html_div([
                        html_h3("🛳️ Cluster", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Clustername: $(Clustername)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Kubernetes Version: $(Kubernetes_version)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("No. of Nodes: $(clusterNodes)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Total Pods: $(pod)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Monitoring: $(monitoring)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Service Mesh: $(ServiceMesh)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Tracing: $(K8s_tracing)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        
                        # "borderRadius" => "10px",
                        # "margin" => "0 auto",
                        # "border" => "2px solid black",
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "flex-wrap" => "wrap",
                        "wordWrap" => "break-word",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                        # html_h4("My Card", style=Dict("marginBottom" => "10px")),
                        html_h3("🎫 MissConfigs", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Critical: $(missconfig_critical)", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("High: $(missconfig_high)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "height" => "130px",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                        # html_h4("My Card", style=Dict("marginBottom" => "10px")),
                        html_h3("🐞 Open Isuues", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Critical: $(missconfig_critical)", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("High: $(missconfig_high)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "height" => "130px",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                            # html_h4("My Card", style=Dict("marginBottom" => "10px")),
                            html_h3("⛔️ Serious Issues", style=Dict("marginBottom" => "15px", "textAlign" => "center", "fontColor" => "red")),
                            html_p("Critical: 0", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                            html_p("High: 0", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "height" => "130px",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                        html_h3("🩹 Closed issues", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Critical: 15", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("High: 6", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "height" => "130px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                        html_h3("🧞 AI Assist (β)", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("AI powered by: Codestral, Deepseek", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("High: 6", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("I am Quite New Here.😉", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "height" => "170px",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px",
                        "flex-wrap" => "wrap"
                    )),
                    html_div([
                        html_h3("💾 Recently Scanned Images", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Name: ghcr.io/samirparhi-dev/weather-aqi-app:latest", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("Signed: yes", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Verified: yes", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "flex-wrap" => "wrap",
                        "marginBottom" => "1px"
                    )),
                    html_div([
                        html_h3(" 🖲️ Latest Changed Infra", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Name: Create Cluster with Security Group", style=Dict("fontSize" => "15px","flex-wrap" => "wrap", "wordWrap" => "break-word", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("Tool: OpenTofu", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Status:🟢", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "height" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px",
                        # "flex-wrap" => "wrap"
                    )),
                    html_div([
                        html_h3(" ⨠ Workflow state", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Create Cluster with Security Group", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Workflow: Container Image Scaning", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                        html_p("Type: GitHub Action", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Status:🟢", style=Dict("fontSize" => "15px", "fontColor" => "red","marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "border" => "1px solid #ccc",
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "height" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px",
                        # "flex-wrap" => "wrap"
                    ))
                ], style=Dict(
                    "display" => "flex",
                    "flex-wrap" => "wrap",
                    "padding" => "5px",
                    "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                    "gap" => "5px",
                    ))
            ],style=Dict(
                
                "flex-grow" => "1",
                "padding" => "30px",
                "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
                "fontSize" => "20px",
                "color" => "darkblue" 
            ))
    elseif path == "/container-security"
        # Return content specific to container security
        return html_div([
                    # Create a card-like div
                    html_div([
                        html_h3("🛳️ Cluster Summary", style=Dict("marginBottom" => "15px", "textAlign" => "center")),
                        html_p("Clustername: $(Clustername)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Kubernetes Version: $(Kubernetes_version)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("No. of Nodes: $(clusterNodes)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Total Pods: $(pod)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Monitoring: $(monitoring)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Service Mesh: $(ServiceMesh)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                        html_p("Tracing: $(K8s_tracing)", style=Dict("fontSize" => "15px", "marginBottom" => "8px")),
                    ],
                    style=Dict(
                        "padding" => "5px",
                        "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
                        "backgroundColor" => "#f9f9f9",
                        "width" => "auto",
                        "textAlign" => "left",
                        "border-radius" => "10px",
                        "wordWrap" => "break-word",
                        "marginBottom" => "1px"
                    ))
                ], style=Dict(
                    "display" => "flex",
                    "flex-wrap" => "wrap",
                    "padding" => "5px",
                    "gap" => "5px",
                    "flex-grow" => "1",
                    "borderRadius" => "10px",
                    "fontFamily" => "Dosis,Verdana, Geneva, sans-serif"
                    ))

                #--- end of main div---
    else
        # 404 Page Not Found
        return html_div([
            html_p("🚧  Getting Build!, Have a nice ☕️  till I am back 🚀", style=Dict(
                    "flex-grow" => "1",
                    "borderRadius" => "10px",
                    "marginBottom" => "8px",
                    "fontFamily" => "Verdana, Geneva, sans-serif",
                    ))
        
            # Add more content as needed
        ],style=Dict(
            "flex-grow" => "1",
            "padding" => "5px",
            "borderRadius" => "10px",
            "boxShadow" => "2px 2px 10px rgba(0, 0, 0, 0.1)",
            "backgroundColor" => "#f9f9f9",
            "display" => "flex",
           "fontFamily" => "Dosis,Verdana, Geneva, sans-serif",
            "flex-wrap" => "wrap"
            ))
    end
end

run_server(app, "0.0.0.0", 8080)
# run_server(app, "0.0.0.0", 8080, debug=true)