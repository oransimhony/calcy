defmodule Calcy.CLI do
    @moduledoc """
    Documentation for the CLI.
    """
    import IO.ANSI

    @doc """
    Calls the REPL without minding the arguments
    """
    def main(_args) do
        {:ok, server} = Calcy.Env.start_link([])
        repl(server)
    end

    @doc """
    Interactive REPL for calcy
    """
    def repl(server) do
        program = IO.gets green() <> "calcy> " <> reset()
        server = Calcy.run(program, server)
        repl(server)
    end
end