defmodule Calcy.Stack do
    use GenServer

    def start_link(default) when is_list(default) do
        GenServer.start_link(__MODULE__, default)
    end

    def push(pid, item) do
        GenServer.cast(pid, {:push, item})
    end

    def pop(pid) do
        GenServer.call(pid, :pop)
    end

    def len(pid) do
        GenServer.call(pid, :length)
    end

    def init(stack) do
        {:ok, stack}
    end

    def handle_call(:pop, _from, [head | tail]) do
        {:reply, head, tail}
    end

    def handle_call(:length, _from, stack) do
        {:reply, length(stack), stack}
    end

    def handle_cast({:push, item}, state) do
        {:noreply, [item | state]}
    end
end