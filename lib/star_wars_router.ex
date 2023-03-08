defmodule StarWarsApi.Router do
  use Plug.Router

  plug Plug.Parsers,
       parsers: [:urlencoded, :json],
       pass: ["*/*"],
       json_decoder: Jason

  plug :match
  plug :dispatch

  get "/movies" do
    movies = StarWarsApi.Repository.get_all_movies()
    send_resp(conn, 200, Jason.encode!(movies))
  end

  get "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = StarWarsApi.Repository.get_movie(id)
    send_resp(conn, 200, Jason.encode!(movie))
  end

  post "/movies" do
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.create_movie(movie)
    send_resp(conn, 201, Jason.encode!(new_movie))
  end

  put "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  patch "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    movie = conn.body_params
    new_movie = StarWarsApi.Repository.update_movie(id, movie)
    send_resp(conn, 200, Jason.encode!(new_movie))
  end

  delete "/movies/:id" do
    id = conn.params["id"] |> String.to_integer()
    StarWarsApi.Repository.delete_movie(id)
    send_resp(conn, 204, "")
  end

  match _ do
    send_resp(conn, 404, "Path doesn't exist.")
  end
end
