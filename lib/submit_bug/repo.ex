defmodule SubmitBug.Repo do
  use Ecto.Repo,
    otp_app: :submit_bug,
    adapter: Ecto.Adapters.SQLite3
end
