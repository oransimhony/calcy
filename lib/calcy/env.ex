defmodule Calcy.Env do
    use GenServer

    @doc """
    Starts the registry.
    """
    def start_link(opts) do
        GenServer.start_link(__MODULE__, :ok, opts)
    end

    def lookup(server, name) do
        GenServer.call(server, {:lookup, name})
    end

    def assign(server, name, value) do
        GenServer.cast(server, {:assign, name, value})
    end

    def init(:ok) do
        {:ok, %{:pi => 3.1415926535897932, :e => 2.718281828459045}}
    end

    def handle_call({:lookup, name}, _from, env) do
        {:reply, Map.fetch(env, name), env}
    end

    def handle_cast({:assign, name, value}, env) do
        case name do
            :pi ->
                raise "Cannot change pi's value"
            :e ->
                raise "Cannot change e's value"
            _ ->
                {:noreply, Map.put(env, name, value)}
        end
    end
end