defmodule MedirepoWeb.Router do
  use MedirepoWeb, :router

  alias MedirepoWeb.Plugs.UUIDChecker

  pipeline :api do
    plug :accepts, ["json"]
    plug UUIDChecker
  end

  scope "/api", MedirepoWeb do
    pipe_through :api

    get "/", RedirectController, :index
    get "/hospitals", RedirectController, :index
    get "/bulletins", RedirectController, :index
    resources "/hospitals", HospitalsController, except: [:index, :new, :edit]
    resources "/bulletins", BulletinsController, except: [:index, :new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MedirepoWeb.Telemetry
    end
  end
end
