defmodule MedirepoWeb.Router do
  use MedirepoWeb, :router

  alias MedirepoWeb.Plugs.UUIDChecker

  pipeline :api do
    plug CORSPlug,
      origin: "*"

    plug :accepts, ["json"]
    plug UUIDChecker
  end

  pipeline :auth do
    plug MedirepoWeb.Auth.Pipeline
  end

  scope "/api", MedirepoWeb do
    pipe_through :api

    get "/", RedirectController, :index
    get "/bulletins", RedirectController, :index
    get "/hospitals/list", HospitalsController, :show_list
    post "/hospitals/reset", HospitalsController, :reset_password
    post "/hospitals", HospitalsController, :create
    post "/hospitals/signin", HospitalsController, :sign_in
    post "/hospitals/fastlogin", HospitalsController, :fast_login
    post "/patients/signin", BulletinViewController, :sign_in
    options "/patients/signin", BulletinViewController, :options
  end

  scope "/api", MedirepoWeb do
    pipe_through [:api, :auth]

    get "/hospitals", HospitalsController, :index
    delete "/hospitals", HospitalsController, :delete
    put "/hospitals", HospitalsController, :update
    get "/patients/view", BulletinViewController, :index
    options "/patients/view", BulletinViewController, :options
    get "/bulletins/list", BulletinsController, :show_list
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

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
