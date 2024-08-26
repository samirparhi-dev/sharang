# PurpleSec : The Productivity app for DevSecOps Team you are waiting For.

## Runing this project

> ### ⚠️ Navigate in to the project root And Run the the below commands

```cd purple-sec```

1. Install Dependency


`julia install_packages.jl`


2. Run the App

`julia app.jl`

3. Install Package for your Project :black_nib:

    - Using Julia `REPL`:

        ```
        using Pkg
        Pkg.add("UUIDs")
        using UUIDs

        my_uuid = uuid4()
        println(my_uuid)
        ```
    - Using Script:
        ```
        julia generateUUID.jl
        ```
4. Build the Project:

`
julia ./src/app.jl
`
