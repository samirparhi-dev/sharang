FROM julia:1.7

WORKDIR /app

COPY . .

RUN julia -e 'using Pkg; Pkg.add(["Dash", "TOML"])'

CMD ["julia", "/app/src/app.jl"]

EXPOSE 8080