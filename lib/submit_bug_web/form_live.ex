defmodule SubmitBugWeb.FormLive do
  use SubmitBugWeb, :live_view

  defp changeset(params) do
    data = %{}
    types = %{name: :string, email: :string}

      {data, types}
      |> Ecto.Changeset.cast(params, Map.keys(types))
      |> Ecto.Changeset.validate_required([:name, :email])
      |> Ecto.Changeset.validate_length(:name, min: 12)
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, saved: false, form: to_form(changeset(%{}), as: :data))}
  end

  def handle_event("validate", %{"data" => params}, socket) do
    cs = changeset(params) |> Map.put(:action, :validate)

    {:noreply, assign(socket, :form, to_form(cs, as: :data))}
  end

  def handle_event("save", %{"data" => params}, socket) do
    cs = changeset(params)

    {:noreply, assign(socket, form: to_form(cs, as: :data), saved: true)}
  end

  def render(assigns) do
    ~H"""
    <.simple_form for={@form} phx-change="validate" phx-submit="save">
      <.input field={@form[:name]} label="Name" phx-debounce="blur" />
      <.input field={@form[:email]} label="E-Mail" phx-debounce="blur" />
      <:actions>
        <.button>Save</.button>
      </:actions>
    </.simple_form>

    <span id="save-indicator" :if={@saved}>Saved!</span>
    """
  end
end
