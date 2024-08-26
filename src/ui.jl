
import Pkg
Pkg.add(["Gtk"])
using Gtk

function build_ui()
    win = GtkWindow("RadeX")
    Gtk.GAccessor.set_default_size(win, 800, 600)
    box = GtkBox(:v)

    # Top Header with GitHub Profile placeholder
    header = GtkBox(:h)
    push!(header, GtkLabel("Connected Apps"))
    github_icon = GtkImage("assets/github_icon.png")
    push!(header, github_icon)
    sign_in_button = GtkButton("Sign in with GitHub")
    push!(header, sign_in_button)
    push!(box, header)

    # Left Sidebar
    sidebar = GtkBox(:v)
    sidebar_menu = ["Cluster Security", "Container Security", "Security Ops", "Policies",
                    "Audits", "Benchmarking", "Performance", "Actions", "Connection",
                    "IaC", "Tracing"]
    for item in sidebar_menu
        push!(sidebar, GtkButton(item))
    end
    push!(box, sidebar)

    # Main Content Area (Initial state: Sign in message)
    main_content = GtkBox(:v)
    main_message = GtkLabel("Please sign in with GitHub to continue.")
    push!(main_content, main_message)
    push!(box, main_content)

    push!(win, box)
    showall(win)
    return win, sign_in_button, github_icon, main_message
end

function update_ui_after_login(user_info, github_icon, main_message)
    # You can add logic to update the github_icon with the user's avatar if available
    set_gtk_label!(main_message, "Welcome, $(user_info["login"])!")
end
