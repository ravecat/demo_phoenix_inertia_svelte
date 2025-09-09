defmodule DemoPhxSv.Repo do
  use Ecto.Repo,
    otp_app: :demo_phx_sv,
    adapter: Ecto.Adapters.Postgres
end
