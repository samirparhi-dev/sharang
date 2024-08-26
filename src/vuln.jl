import Pkg
Pkg.add(["HTTP", "JSON", "Dash"])

using HTTP
using JSON
using Dash

# Load the JSON data
json_data = JSON.parsefile("trivy-report.json")

function extract_vulnerability_info(json_data)
    findings = json_data["Findings"]
    vulnerability_info = []
    
    for finding in findings
        if haskey(finding, "Results")
            for result in finding["Results"]
                if haskey(result, "Vulnerabilities")
                    for vulnerability in result["Vulnerabilities"]
                        # vendor_severity = join([string(vendor["id"], ": ", vendor["severity"]) for vendor in get(vulnerability, "VendorSeverities", [])], ", ")
                        push!(vulnerability_info, (
                            VulnerabilityID = get(vulnerability, "VulnerabilityID", ""),
                            # PkgName = get(result, "Target", ""),
                            # SeveritySource = get(vulnerability, "SeveritySource", ""),
                            # DataSource = get(vulnerability, "DataSource", ""),
                            CweIDs = Vector{String}(get(vulnerability, "CweIDs", [])),
                            CVSS_ID = get(vulnerability, "CVSS", Dict{String,Any}()) |> x -> get(x, "Metrics", Dict{String,Any}()) |> x -> get(x, "id", ""),
                            Severity = get(vulnerability, "Severity", ""),
                            # VendorSeverity = vendor_severity
                        ))
                    end
                end
            end
        end
    end
    
    return vulnerability_info
end

vulnerability_info = extract_vulnerability_info(json_data)

println(vulnerability_info)

# Convert the vulnerability_info to a string
formatted_content = join([string(info) for info in vulnerability_info], "\n")

open("vulnerability_info.json", "w") do file
    write(file, formatted_content)
end

app = dash()
app = dash(external_stylesheets = ["/assets/style.css"])
app.title = "RadeX"
app.layout = Dash.html_div(
    children=[
        Dash.html_h1("RadeX"),
        Dash.html_table(
            children=[
                Dash.html_tr([
                    Dash.html_th("Vulnerability ID"),
                    Dash.html_th("CweIDs"),
                    Dash.html_th("CVSS ID"),
                    Dash.html_th("Severity")
                    # Dash.html_th("PkgName"),
                    # Dash.html_th("DataSource"),
                    # Dash.html_th("Severity Score"),
                    # Dash.html_th("Vendor Severity")
                ]),
                [Dash.html_tr([
                    Dash.html_td(info.VulnerabilityID),
                    Dash.html_td(info.CweIDs),
                    Dash.html_td(info.Severity),
                    Dash.html_td(info.CVSS_ID)
                    # Dash.html_td(Dash.html_a(href=info.DataSource, children="Link")),
                    # Dash.html_td(info.Severity),
                    # Dash.html_td(info.VendorSeverity)
                ]) for info in vulnerability_info]
            ]
        )
    ]
)

run_server(app, "127.0.0.1", 8050)
